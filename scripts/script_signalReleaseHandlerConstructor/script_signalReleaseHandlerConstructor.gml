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
			show_message(currentSignal);
			signalReference[$ currentSignalData[0]] = currentSignal; // load into reference struct
		}
		activeQueueNames = storedSignalActiveList[$ "ActiveList"];
		for (var i = 0; i < array_length(activeQueueNames); i++) {
			activeSignalList.append(signalReference[$ activeQueueNames[i]]);
		}
		show_message(activeSignalList);
	}
	
	static checkToBeAddedIntoQueue = function(currentTime) { // run on tick check, scroll through repository and add to active queue if stuff is active or nah
		var signalNames = struct_get_names(signalReference);
		var length = struct_names_count(signalReleaseData);
		for (var i = 0; i < length; i++) {
			var currentSignalName = signalNames[i];
			if (signalCompletionMap[$ currentSignalName] == true) { // object has already been completed
				show_debug_message("SIGNAL HAS ALREADY BEEN COMPLETED");
				continue;
			}
			var currentSignal = signalReference[$ currentSignalName];
			if (currentSignal.getHasBeenReleased()) {
				show_debug_message("SIGNAL ALREADY RELEASED");
				continue;
			}
			if (!currentSignal.isTimeEligible(currentTime)) {
				show_debug_message("SIGNAL NOT READY YET");
				continue;
			}
			show_message(currentSignal.getName() + " HAS BEEN RELEASED");
			activeSignalList.append(currentSignal); // all checks passed, put into the array
			currentSignal.updateHasBeenReleased(true);
		}
	}
	static getActiveSignalList = function() {
		return activeSignalList;
	}	
	
}