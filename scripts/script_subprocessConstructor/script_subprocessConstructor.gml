// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createSubprocess(_isRunning, _subProcessType) constructor {
	isRunning = _isRunning; // boolean to determine whether subprocess is considered active or not;
	subProcessType = _subProcessType; // string, determines type of subprocess
	
	static setIsRunning = function(state) {
		isRunning = state;
	}
	
	static getIsRunning = function() {
		return isRunning;
	}
}