// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createSignalSelector(_activeList) constructor {
	activeList = _activeList;
	currentPosition = 0;
	
	static getActiveList = function() {
		return activeList;
	}
	
	static updateActiveList = function(newList) {
		activeList = newList;
	}
	
	static getCurrentSignalName = function() { // return string of name
		return activeList.getItem(currentPosition).getName();
	}
	
	static getCurrentSignal = function() {
		return activeList.getItem(currentPosition);
	}
	
	static getCurrentSignalID = function() {
		return activeList.getItem(currentPosition).getSignalID();
	}
	
	static getCurrentSignalAnswerData = function() { // return signalData object
		return activeList.getItem(currentPosition).getSolutionData();
	}
	static getCurrentSignalAudioData = function() {
		return activeList.getItem(currentPosition).getAudioData();
	}
	
	static forwardPosition = function() {
		currentPosition++;
		if (currentPosition >= activeList.getLength()) {
			currentPosition = 0;
		}
	}
	static backwardPosition = function() {
		currentPosition--;
		if (currentPosition < 0) {
			currentPosition = activeList.getLength()-1;
		}
	}
	static isEmpty = function() {
		return activeList.isEmpty();
	}
}