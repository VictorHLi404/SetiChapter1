// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createClock(_currentTime) constructor {
	currentTime = _currentTime;
	
	static advanceTime = function() {
		currentTime += 1;
		if (currentTime > 23) { // loop around to 0 for new day
			currentTime = 0;
		}
	}
	
	static getTimeString = function() {
		if (currentTime < 10) {
			return ("0" + string(currentTime) + ":00");
		}
		else {
			return (string(currentTime) + ":00");
		}
	}
}