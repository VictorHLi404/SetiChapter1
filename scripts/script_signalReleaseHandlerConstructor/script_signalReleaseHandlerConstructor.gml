// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createSignalReleaseHandler(_fileList) : createDataHandler(_fileList) constructor {
	
	signalReleaseData = fileData[$ fileNames[0]]; // jsonf ile with all of the relavent data
	signalCompletionMap = fileData[$ fileNames[1]]; // json file with boolean map of completion
	storedSignalActiveList = fileData[$ fileNames[2]]; // json file with previous active signal list
	activeSignalList = new createQueue(); // list that is used for dropdown menu / signals that are currently active to look at
	signalReference = {}; // name : signalData, easy access object
	
	static decompileSignalJSON = function(JSONStruct) {
		var dataArray = [];
		dataArray[0] = JSONStruct[$ "SignalID"]; // string
		dataArray[1] = JSONStruct[$ "Name"]; // string
		dataArray[2] = JSONStruct[$ "MinimumTimeElapsed"]; // int
		dataArray[3] = JSONStruct[$ "HasBeenReleased"]; // boolean
		dataArray[4] = JSONStruct[$ "AudioData"]; // struct
		dataArray[5] = JSONStruct[$ "SolutionData"]; // struct
		dataArray[6] = JSONStruct[$ "UponCompletionTasks"]; // array
		return dataArray;
	}
	
	static initializeHandler = function() { // load data from the saved active signal list, + put everything into the handler
		var signalNames = struct_get_names(signalReleaseData);
		var length = struct_names_count(signalReleaseData);
		for (var i = 0; i < length; i++) {
			var currentSignalData = decompileSignalJSON(signalReleaseData[$ signalNames[i]]);
			var currentSignal = new createSignalData(currentSignalData[0], currentSignalData[1], currentSignalData[2], currentSignalData[3], currentSignalData[4], currentSignalData[5], currentSignalData[6]); 
			signalReference[$ currentSignalData[0]] = currentSignal; // load into reference struct
		}
		activeQueueNames = storedSignalActiveList[$ "ActiveList"];
		for (var i = 0; i < array_length(activeQueueNames); i++) {
			activeSignalList.append(signalReference[$ activeQueueNames[i]]);
		}
	}
	
	static checkToBeAddedIntoQueue = function(currentTime) { // run on tick check, scroll through repository and add to active queue if stuff is active or nah
		var signalNames = struct_get_names(signalReference);
		var length = struct_names_count(signalReleaseData);
		for (var i = 0; i < length; i++) {
			var currentSignalName = signalNames[i];
			if (signalCompletionMap[$ currentSignalName] == true) { // object has already been completed
				//show_debug_message("SIGNAL HAS ALREADY BEEN COMPLETED");
				continue;
			}
			var currentSignal = signalReference[$ currentSignalName];
			if (currentSignal.getHasBeenReleased()) {
				//show_debug_message("SIGNAL ALREADY RELEASED");
				continue;
			}
			if (!currentSignal.isTimeEligible(currentTime)) {
				//show_debug_message("SIGNAL NOT READY YET");
				continue;
			}
			//show_message(currentSignal.getName() + " HAS BEEN RELEASED");
			activeSignalList.append(currentSignal); // all checks passed, put into the array
			currentSignal.updateHasBeenReleased(true);
		}
	}
	
	static removeSignalFromQueue = function(signalID) {
		for (var i = 0; i < activeSignalList.getLength(); i++) {
			if (activeSignalList.getItem(i).getSignalID() == signalID) {
				activeSignalList.removeIndex(i);
				return;
			}
		}
		show_debug_message("NO SIGNAL FOUND IN QUEUE");
		return;
	}
	
	static evaluateSignalAccuracy = function(currentPlayerResponseKey, currentSignal) { // return float between 0 and 1 reperesenting general accuracy of how close the player was to the signal
		var answerKey = currentSignal.getSolutionData();
		var taskLengthMultiplier = 0; // add to this to determine how much time to add depending on success
		// [locationArray, minimum distance, upper pitch, lower pithc, upper gian, lower gain]
		// [distance, upperPitch, lowerPitch, upperGain, lowerGain]
		
		/// evaluate distance - worth 0.5
		// (minimum distance - distance to point) / miniumum distance provides value between 0 to 1
		// closer to 1 = better
		// x^2 curve to ease in values
		var minimumDistance = answerKey[1];
		var evaluatedDistance = currentPlayerResponseKey[0];
		//show_message("MINIMUM DISTANCE IS " + string(minimumDistance));
		//show_message("EVALUATED DISTANCE IS " + string(evaluatedDistance));
		//show_message("DISTANCE SCORE IS " + string(0.5*power(((minimumDistance-evaluatedDistance)/minimumDistance), 2)));
		taskLengthMultiplier += 0.5*power(((minimumDistance-evaluatedDistance)/minimumDistance), 2)

		
		// evaluate pitch - worth 0.15 each
		var upperPitchAnswer = answerKey[2];
		var upperPitchResponse = currentPlayerResponseKey[1]; 
		var lowerPitchAnswer = answerKey[3];
		var lowerPitchResponse = currentPlayerResponseKey[2];
		// absolute difference between answer and response = 0-10, convert to 0-1
		// 0.15 * (1 - x^2)
		taskLengthMultiplier += 0.15*(1-(power(abs(upperPitchAnswer-upperPitchResponse)/10, 2)));
		taskLengthMultiplier += 0.15*(1-(power(abs(lowerPitchAnswer-lowerPitchResponse)/10, 2)));
		//show_message("UPPER PITCH SCORE IS " + string(0.15*(1-(power(abs(upperPitchAnswer-upperPitchResponse)/10, 2)))));
		//show_message("LOWER PITCH SCORE IS " + string(0.15*(1-(power(abs(lowerPitchAnswer-lowerPitchResponse)/10, 2)))));
		// evaluate gain - worth 0.10 each, repeat above steps
		var upperGainAnswer = answerKey[4];
		var lowerGainAnswer = answerKey[5];
		var upperGainResponse = currentPlayerResponseKey[3];
		var lowerGainResponse = currentPlayerResponseKey[4];
		taskLengthMultiplier += 0.10*(1-(power(abs(upperGainAnswer-upperGainResponse)/10, 2)));
		taskLengthMultiplier += 0.10*(1-(power(abs(lowerGainAnswer-lowerGainResponse)/10, 2)));
		//show_message("UPPER GAIN SCORE IS " + string(0.10*(1-(power(abs(upperGainAnswer-upperGainResponse)/10, 2)))))
		//show_message("LOWER GAIN SCORE IS " + string(0.10*(1-(power(abs(lowerGainAnswer-lowerGainResponse)/10, 2)))))
		return taskLengthMultiplier;
	}
	
	static getActiveSignalList = function() {
		return activeSignalList;
	}

	
	static releaseCompletionTasks = function(currentSignal) { // look through the uponcompletion tasks, check if they have been released yet or not, then release them into global.taskHandler
	}
	
	static submitSignal = function(currentSignalID, currentPlayerResponseKey) { // called by player when they want to finalize their decision
	removeSignalFromQueue(currentSignalID);
	var currentSignal = signalReference[$ currentSignalID];
	// evaluate accuracy
	var taskLengthMultipler = 1/evaluateSignalAccuracy(currentPlayerResponseKey, currentSignal);
	show_message(taskLengthMultipler);
	// release completion tasks
	global.taskHandler.loadSignalTasks(currentSignal.getUponCompletionTasks(), taskLengthMultipler);
	// kick to a submitting screen

	}
	
}