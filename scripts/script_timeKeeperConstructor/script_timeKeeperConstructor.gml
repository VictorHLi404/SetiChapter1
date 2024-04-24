// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createTimeKeeper(_dataHandler) constructor {
	// time in game runs on a TICK BASED SYSTEM, alarm within timekeeper object to update time as real time goes forawrd
	// timekeeper sends out a "pulse" every time the currentTime is updated, listener objects / event handlers wait for pulse and then work from there
	dataHandler = _dataHandler;
	currentTime = global.INT_MIN; // MOST IMPORTANT VARIABLE, stores the current tick time of the game
	timeProgressionNormal = true; // keeps track of whether to progress the game fast (in menu / waffling around) or slow (in event / conversation)
	newTick = false; // keeps track of whether a "pulse" is active
	
	static loadCurrentTime = function() { // reads from currentTIme stored inside of currentWorldData.json
		var storedCurrentTime = dataHandler.getValue("currentWorldTime", "currentWorldData.json");
		currentTime = storedCurrentTime;
		show_debug_message("THIS IS THE CURRENT TIME")
		show_debug_message(storedCurrentTime);
	}
	
	static moveTimeForward = function() {
		currentTime += 1;
		dataHandler.updateValue(currentTime, "currentWorldTime", "currentWorldData.json");
	}
	
	static setTimeProgressionStatus = function(status) {
		timeProgressionNormal = status;
	}
	
	static getTimeProgressionStatus = function() {
		return timeProgressionNormal;
	}
	static getCurrentTime = function() {
		return currentTime;
	}
	
	static isPulseOngoing = function() {
		return newTick;
	}
	
	static startPulse = function() {
		newTick = true;
	}
	
	static endPulse = function() {
		newTick = false;
	}
	
}