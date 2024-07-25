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
	
	static getCurrentSubprocess = function() {
		return currentSubprocess;
	}
	
	static getSubprocessBonuses = function() {
		return currentSubprocess.getSubprocessBonuses();
	}
	
	static updateCurrentSubprocess = function(newSubprocess) {
		currentSubprocess = newSubprocess;
	}
	
	static updateNodeType = function() {
		type = currentSubprocess.getSubprocessID() + "Cell";
	}
	
	
}