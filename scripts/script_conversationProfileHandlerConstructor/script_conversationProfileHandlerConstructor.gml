// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationProfileHandler(_fileList) : createDataHandler(_fileList) constructor {
	// only pass in one argument, conversationStack.json, pull resulting json from there
	profileIconViewCount = 4; // # of profiles put on display at a time
	profileStackData = fileData[$ fileNames[0]][$ "ProfileStack"]; 
	addFiles(array_concat([fileNames[0]], profileStackData)); // need 2 reinsert the original file ot make sure it doesnt get overwitten
	blankProfile = new createNPCProfile("BlankProfile","","","","","","","","");
	
	conversationReleaser = new createConversationReleaser(["ConversationReleaseSystem.json", "ConversationCompletionMap.json"]);
	profileStack = new createStack();
	
	conversationStandbyQueue = conversationReleaser.getConversationStandbyQueue();
	
	currentConversationToLoad = "";
	currentNPCToLoad = "";
	
	static decompileJSON = function(JSONStruct) { // decompile a profile json into array
		var dataArray = [];
		dataArray[0] = JSONStruct[$ "Name"];
		dataArray[1] = JSONStruct[$ "FileName"];
		dataArray[2] = JSONStruct[$ "Details"][$ "Position"];
		dataArray[3] = JSONStruct[$ "Details"][$ "Division"];
		dataArray[4] = JSONStruct[$ "Details"][$ "SecurityClearance"];
		dataArray[5] = JSONStruct[$ "Details"][$ "EmploymentDate"];
		dataArray[6] = JSONStruct[$ "Details"][$ "DateOfBirth"];
		dataArray[7] = JSONStruct[$ "Details"][$ "PersonalTerminalID"];
		dataArray[8] = JSONStruct[$ "Details"][$ "PreviousConversations"];
		return dataArray;
	}
	
	static initializeStack = function() {
		for (var i = 0; i < array_length(profileStackData); i++) { // iterate through filelist ignoring the stack.json and load into the stack object
			var storedProfileData = decompileJSON(fileData[$ fileNames[i+1]]);
			var storedProfile = new createNPCProfile(storedProfileData[0], storedProfileData[1], storedProfileData[2], storedProfileData[3],
													storedProfileData[4], storedProfileData[5], storedProfileData[6], storedProfileData[7], storedProfileData[8]);
			profileStack.insert(storedProfile);
		}
	}
	
	static getDisplayProfileData = function(startIndex) { // return array that contians the active 4 profiles currently in view
		var tempArray = [];
		for (var i = startIndex; i < profileIconViewCount+startIndex; i++) {
			if (i >= profileStack.getLength()) {
				tempArray[i-startIndex] = blankProfile;	
			}
			else {
				tempArray[i-startIndex] = profileStack.getItem(i);
			}
		}
		return tempArray;
	}
	
	static loadNewConversations = function(currentTime) {
		conversationReleaser.loadConversationsIntoQueue(currentTime);
		return;
	}
	
	static updateConversationStandbyQueue = function() {
		conversationStandbyQueue = conversationReleaser.getConversationStandbyQueue();
		return;
	}
	
	static progressTime = function() { // iterate through conversations and tick down eligible time; if no longer eligible, kick out of the queue
		for (var i = 0; i < conversationStandbyQueue.getLength(); i++) {
			var conversationReference = conversationStandbyQueue.getItem(i);
			conversationReference.progressEligibleTime();
		}
		return;
	}
	
	static evaluateTimeEligbility = function() {
		for (var i = 0; i < conversationStandbyQueue.getLength(); i++) {
			var conversationReference = conversationStandbyQueue.getItem(i);
			if (!conversationReference.isCurrentlyEligible()) { // if time runs out
				conversationStandbyQueue.removeIndex(i);
				//show_message(conversationReference.getConversationID() + " HAS EXPIRED");
				for (var j = 0; j < profileStack.getLength(); j++) {
					var profileReference = profileStack.getItem(j);
					if (conversationReference.getNPCFileName() == profileReference.getFileName()) {
						profileReference.unloadCurrentConversation();
					}
				}	
			}
		}
		return;
	}
	
	static loadConversationsIntoProfile = function() { // O(n)^2 : if laggy, redo this one
		for (var i = 0; i < conversationStandbyQueue.getLength(); i++) {
			var conversationReference = conversationStandbyQueue.getItem(i);
			for (var j = 0; j < profileStack.getLength(); j++) {
				var profileReference = profileStack.getItem(j);
				if (conversationReference.getNPCFileName() == profileReference.getFileName()) { // if the person doesnt already exist
					if (profileReference.getHasCurrentConversation()) {
						if (profileReference.getCurrentConversationFileName() != conversationReference.getConversationFileName()) {
							conversationReference.delayEligibleTime();
						}
					}
					else {
						profileReference.loadCurrentConversation(conversationReference.getConversationFileName());
						//show_message(profileReference);
					}
				}
			}
		}
	}

	
	static getBlankProfile = function() {
		return blankProfile;
	}
	
	static getProfileIconViewCount = function() {
		return profileIconViewCount;
	}
	
	static getProfileStackLength = function() {
		return profileStack.getLength();	
	}
	
	static updateConversationToLoad = function(conversationFileName, conversationNPCFileName) {
		currentConversationToLoad = conversationFileName;
		currentNPCToLoad = conversationNPCFileName;
	}
	
	static getCurrentConversationToLoad = function() {
		return currentConversationToLoad;	
	}
	
	static getCurrentNPCToLoad = function() {
		return currentNPCToLoad;
	}
}