// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createProcessingCell(_type, _x, _y, _imageAngle, _active, _currentSubprocess) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor {
	currentSubprocess = _currentSubprocess; // data object that contains whatever the process / routine the object represents contains
	
	static isBlank = function() {
		if (type == "BlankCell") {
			return true;
		}
		else {
			return false;
		}
	}
	
	static isValidCell = function() { // if subprocess is currently not uncorrupted 
		if (currentSubprocess.isCorrupted() || currentSubprocess.isInProgress()) {
			return false;
		}
		else {
			return true;
		}
	}

	static isFunctionalCell = function() { // if its a cell that contributes to the bonuses / not just a data cell
		if (isValidCell() && !currentSubprocess.isDataCell()) {
			return true;
		}
		else {
			return false;
		}
	}
	
	static getCurrentSubprocess = function() {
		return currentSubprocess;
	}
	
	static getSubprocessBonuses = function() {
		return currentSubprocess.getSubprocessBonuses();
	}
	
	static updateCurrentSubprocess = function(newSubprocess) {
		currentSubprocess = newSubprocess;
		return;
	}
	
	static updateNodeType = function(parentNode, horizontalIndex, verticalIndex) {
		type = parentNode + "/" + horizontalIndex + verticalIndex + "/" + currentSubprocess.getSubprocessID() + "Cell";
		return;
	}
	
	static getName = function() {
		return currentSubprocess.getSubprocessName();
	}
	
	static getDescription = function() {
		return currentSubprocess.getSubprocessDescription();
	}
	
	static setCorruptedToInProgress = function() {
		if (currentSubprocess.isCorrupted()) {
			currentSubprocess.setToInProgress();
		}
	}
	
	
}