// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationReleaseObject(_JSONStruct) constructor {
	conversationID = _JSONStruct[$ "ConversationID"]; // string
	conversationName = _JSONStruct[$ "ConversationName"]; // string
	conversationFileName = _JSONStruct[$ "ConversationFileName"]; // string, path to the json file of the conversation
	NPCFileName = _JSONStruct[$ "NPCFileName"]; // stirng, path to the json file of the relatedNPC;
	minimumTimeElapsed = _JSONStruct[$ "MinimumTimeElapsed"]; // int, minimum time b4 object can be officially released
	maximumTimeElapsed = _JSONStruct[$ "MaximumTimeElapsed"]; // int, maximum time conversation can be considered valid to be released
	remainingEligibleTime = _JSONStruct[$ "RemainingEligibleTime"]; // int, time that the conversation is up and valid for
	timeOfDay = _JSONStruct[$ "TimeOfDay"]; // int, time within 24 hour tick cycle that the conversation should be released
	
	NPCFlags = _JSONStruct[$ "NPCFlags"]; // struct, stores list of flags contained by NPC that need to be met
	playerFlags = _JSONStruct[$ "PlayerFlags"]; // struct, stores list of flags contained by player that need to be met
	taskFlags = _JSONStruct[$ "TaskFlags"]; // struct, stores list of tasks that need to be met for object to be released
	worldFlags = _JSONStruct[$ "WorldFlags"]; // struct, stores list of universal effects that need to be met for object to be released
	
	
	// structs of flags and tasks to be released upon conversation completion regardless of what happens
	uponCompletionNPCFlags = _JSONStruct[$ "CompletionFlags"][$ "NPCFlags"];
	uponCompletionPlayerFlags = _JSONStruct[$ "CompletionFlags"][$ "PlayerFlags"];
	uponCompletionWorldFlags = _JSONStruct[$ "CompletionFlags"][$ "WorldFlags"];
	uponCompletionTasks = _JSONStruct[$ "CompletionTasks"];
	
	
	static isReleaseTimeEligible = function(currentTime) { // take in current tick time and compare to eligiblity
		if (minimumTimeElapsed <= currentTime && currentTime <= maximumTimeElapsed) {
			return true;
		}
		else {
			return false;
		}
	}
	
	static progressEligibleTime = function() {
		remainingEligibleTime -= 1;
		return;
	}
	
	static isCurrentlyEligible = function() {
		if (remainingEligibleTime > 0) {
			return true;
		}
		else {
			return false;
		}
	}
	
	static delayEligibleTime = function() { // if its just sitting in queue waiting to happen but another conversation is already there, then delay time by 1 tick to keep it "suspended"
		remainingEligibleTime += 1;
		return;
	}
	
	static getNPCFileName = function() {
		return NPCFileName;
	}
	
	static getNPCFlags = function() {
		return NPCFlags;
	}
	
	static getPlayerFlags = function() {
		return playerFlags;
	}
	
	static getTaskFlags = function() {
		return taskFlags;
	}
	
	static getWorldFlags = function() {
		return worldFlags;
	}
	
	static getConversationID = function() {
		return conversationID;
	}
	
	static getConversationFileName = function() {
		return conversationFileName;
	}
}

function createConversationReleaser(_fileList) : createDataHandler(_fileList) constructor {
	conversationReleaseData = fileData[$ fileNames[0]]; // big json that contains all of the data
	conversationCompletionMap = fileData[$ fileNames[1]]; // json that contains map of whether conversations have been completed or not
	conversationStandbyQueue = new createQueue(); // queue that contains conversations that are currently player accessible
	
	static evaluateBoolean = function(firstBoolean, secondBoolean) {
		return (firstBoolean == secondBoolean);
	}
	
	static evaluateInteger = function(firstInteger, secondInteger, comparator) {
		if (comparator == "GREATER") {
			return (firstInteger >= secondInteger);
		}
		else if (comparator == "LESSER") {
			return (firstInteger <= secondInteger);
		}
	}
	
	static evaluateNPCConditionals = function(NPCFlags, NPCFile) { // boolean if conditions are met
		
		if (struct_names_count(NPCFlags) == 0) { // if struct is empty
			return true;
		}
		// run through all of the flags, return false if anything doesnt match up, return true otherwise
		var flagNames = struct_get_names(NPCFlags);
		var structLength = struct_names_count(NPCFlags);
		
		for (var i = 0; i < structLength; i++) {
			if (string_contains("Fear", flagNames[i]) || string_contains("Trust", flagNames[i]) || string_contains("Agreeability", flagNames[i])) { // integer stat check
				var comparator = "";
				if (real(NPCFlags[$ flagNames[i]]) < 0) {
					comparator = "LESSER";
				}
				else {
					comparator = "GREATER";
				}
				if (!evaluateInteger(real(NPCFile[$ "Stats"][$ flagNames[i]]), abs(real(NPCFlags[$ flagNames[i]])), comparator)) {
					show_message(flagNames[i] + " FAILED");
					return false;
				}
			}
			else { // boolean flag
				if (!evaluateBoolean(NPCFile[$ "Flags"][$ flagNames[i]], NPCFlags[$ flagNames[i]])) {
					show_message(flagNames[i] + " FAILED");
					return false;
				}
			}
		}	
		return true;
	}
	
	static evaluateGeneralConditionals = function(TaskFlags, TaskFile) { // boolean if conditions are met
		if (struct_names_count(TaskFlags) == 0) { // if struct is empty
			return true;
		}
		var flagNames = struct_get_names(TaskFlags);
		var structLength = struct_names_count(TaskFlags);
		
		for (var i = 0; i < structLength; i++) {	
			if (!evaluateBoolean(TaskFlags[$ flagNames[i]], TaskFile[$ flagNames[i]])) {
				show_message(flagNames[i] + " INCOMPLETE");
				return false;
			}
		}
		return true;
	}
		
	static loadConversationsIntoQueue = function(currentTime) {
		var length = struct_names_count(conversationCompletionMap);
		var conversationNames = struct_get_names(conversationCompletionMap);
		for (var i = 0; i < length; i++) {
			if (conversationCompletionMap[$ conversationNames[i]] == true) { // if conversation has already been loaded, skip
				continue;
			}
			var temporaryConversationObject = new createConversationReleaseObject(conversationReleaseData[$ conversationNames[i]]);
			if (!temporaryConversationObject.isReleaseTimeEligible(currentTime)) { // if conversation is not currently time eligible, skip
				continue;
			}
			// [npcfile, playerfile, taskcompletionmap, worldflags
			// change to use the global data handler if things get slow 
			var NPCFileName = temporaryConversationObject.getNPCFileName();
			var temporaryHandler = new createDataHandler([NPCFileName, "PlayerData.json", "TaskCompletionMap.json", "currentWorldData.json"]);
			var NPCFile = temporaryHandler.getFile(NPCFileName);
			
			if (!evaluateNPCConditionals(temporaryConversationObject.getNPCFlags(), NPCFile)) {
				show_message("NPC CHECK FAILED");
				continue;
			}
			var playerFile = temporaryHandler.getFile("PlayerData.json");
			if (!evaluateNPCConditionals(temporaryConversationObject.getPlayerFlags(), playerFile)) {
				show_message("PLAYER CHECK FAILED");
				continue;
			}
			var taskFile = temporaryHandler.getFile("TaskCompletionMap.json");
			if (!evaluateGeneralConditionals(temporaryConversationObject.getTaskFlags(), taskFile)) {
				show_message("TASK CHECK FAILED");
				continue;
			}
			var worldFile = temporaryHandler.getFile("currentWorldData.json");
			if (!evaluateGeneralConditionals(temporaryConversationObject.getWorldFlags(), worldFile)) {
				show_message("WORLD CHECK FAILED");
				continue;
			}
			//show_message(conversationNames[i] + " VALID TO BE LOADED");
			// all checks have been passed
			conversationStandbyQueue.append(temporaryConversationObject);
			conversationCompletionMap[$ conversationNames[i]] = true;
		}	
	}
	
	static getConversationStandbyQueue = function() {
		return conversationStandbyQueue;
	}
}