// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createSubprocess(_subProcessID, _subProcessName, _subprocessDescription, _subProcessType, _subProcessEffect) constructor {
	subprocessID = _subProcessID; // string, read to access related file for loading
	subprocessDescription = _subprocessDescription;
	subprocessName = _subProcessName; // string, read only for display
	subprocessType = _subProcessType; // string, determines type of subprocess + display
	subprocessEffect = _subProcessEffect; // float, multiplicative value that determines certain buffs or not
	
	static getSubprocessID = function() {
		return subprocessID;
	}
	
	static getSubprocessName = function() {
		return subprocessName;
	}
	
	static getSubprocessDescription = function() {
		return subprocessDescription;
	}
	
	static getSubprocessBonuses = function() { // returns [type, effect]
		return [subprocessType, subprocessEffect];
	}
	
	static getSubprocessType = function() {
		return subprocessType;
	}
	
	static isCorrupted = function() {
		if (subprocessType == "Corrupted") {
			return true;
		}
		else {
			return false;
		}
	}
	
	static isInProgress = function() {
		if (subprocessType == "InProgress") {
			return true;
		}
		else {
			return false;
		}
	}
	
	static isCoreFunction = function() {
		if (subProcessType == "CoreFunction") {
			return true;
		}
		else {
			return false;
		}
	}
	
	static isDataCell = function() {
		return (subprocessType == "Data");
	}
	
	static setToInProgress = function() {
		subprocessDescription = "IN REPAIR";
		subprocessType = "InProgress";
	}
}