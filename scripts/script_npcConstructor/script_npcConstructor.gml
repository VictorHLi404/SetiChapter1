// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createNPC(_dataHandler, _npcFileName) constructor {

	dataHandler = _dataHandler;
	npcFileName = _npcFileName;
	NPCName = dataHandler.getValue("Name", npcFileName);
	currentAgreeability = dataHandler.getValue("currentAgreeability", npcFileName);
	currentTrust = dataHandler.getValue("currentTrust", npcFileName);
	currentFear = dataHandler.getValue("currentFear", npcFileName);
	
	static evaluateSufficientAgreeability = function(minimum) {
		if (currentAgreeability >= minimum)  {
			return true;
		}
		else {
			return false;
		}
	}
	show_message(string(currentAgreeability) +  string(currentTrust) + string(currentFear));
	
	static updateAgreeability = function(updateValue) {
		currentAgreeability += updateValue;
	}
	
	static conditionIsMet = function(conditionName) {
		booleanValue = dataHandler.getValue(conditionName, npcFileName);
		return booleanValue;
	}
	
	static updateValue = function(valueName, value) {
		if (valueName == "agreeability") {
			updateAgreeability(value);
		}
		show_debug_message(currentAgreeability);
	}
	
}