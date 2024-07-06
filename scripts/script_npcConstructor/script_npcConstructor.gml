 // Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createNPC(_dataHandler, _fileName) constructor { // IMPLEMENT WRITING BACK TO THE JSON FILE FOR ALL VALUES

	dataHandler = _dataHandler;
	fileName = _fileName;
	NPCName = dataHandler.getValue("Name", fileName);
	currentAgreeability = dataHandler.getValue("currentAgreeability", fileName);
	currentTrust = dataHandler.getValue("currentTrust", fileName);
	currentFear = dataHandler.getValue("currentFear", fileName);
	
	currentBooleanFlags = dataHandler.getStruct("Flags", fileName);
	show_message(currentBooleanFlags);
	// TODO Clean this section up for redundancy this shit is terrrrrrible	
	
	evaluateAgreeability = function(equalityType, value) {
		if (equalityType == ">=")  {
			return (currentAgreeability >= value);
		}
		else if (equalityType == "<=") {
			return (currentAgreeability <= value);
		}
		else if (equalityType == "==") {
			return (currentAgreeability == value);
		}
	}
	
	evaluateTrust = function(equalityType, value) {
		if (equalityType == ">=")  {
			return (currentTrust >= value);
		}
		else if (equalityType == "<=") {
			return (currentTrust <= value);
		}
		else if (equalityType == "==") {
			return (currentTrust == value);
		}
	}
	
	evaluateFear = function(equalityType, value) {
		if (equalityType == ">=")  {
			return (currentFear >= value);
		}
		else if (equalityType == "<=") {
			return (currentFear <= value);
		}
		else if (equalityType == "==") {
			return (currentFear == value);
		}
	}
	
	evaluateIntegerValue = function(valueName, equalityType, value) {
		if (valueName == "agreeability") {
			return evaluateAgreeability(equalityType, value);
		}
		else if (valueName == "trust") {
			return evaluateTrust(equalityType, value);
		}
		else if (valueName == "fear") {
			return evaluateFear(equalityType, value);
		}
	}
	
	updateAgreeability = function(updateValue) {
		currentAgreeability += updateValue;
	}
	
	updateTrust = function(updateValue) {
		currentTrust += updateValue;
	}

	updateFear = function(updateValue) {
		currentFear += updateValue;
	}
	
	evaluateBooleanConditional = function(flagName) {
		return currentBooleanFlags[$ flagName];
	}
	
	updateBooleanValue = function(flagName, booleanState) {
		currentBooleanFlags[$ flagName] = booleanState;
		show_message(currentBooleanFlags);
	}
	
	updateIntegerValue = function(valueName, value) { // change for redundancy later?
		if (valueName == "agreeability") {
			updateAgreeability(value);
		}
		else if (valueName == "trust") {
			updateTrust(value);
		}
		else if (valueName == "fear") {
			updateFear(value);
		}
		show_debug_message(currentAgreeability);
	}
	
	getAgreeability = function() {
		return currentAgreeability;
	}
	
	getName = function() {
		return NPCName;
	}
	
	getFileName = function() {
		return fileName;
	}
	
	recompileIntoJSON = function() {
		recompiledFile = {};
		recompiledFile[$ "Name"] = NPCName;
		recompiledFile[$ "Stats"] = {};
		recompiledFile[$ "Stats"][$ "currentAgreeability"] = currentAgreeability;
		recompiledFile[$ "Stats"][$ "currentTrust"] = currentTrust;
		recompiledFile[$ "Stats"][$ "currentFear"] = currentFear;
		recompiledFile[$ "Flags"] = currentBooleanFlags;
		return recompiledFile;
	}
}