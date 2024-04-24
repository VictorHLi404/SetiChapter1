/// @description Insert description here
// You can write your code in this editor
// check if countdown ongoing

if (!countdownOngoing) { // check if a new tick needs to be triggered
	if (global.timeKeeper.getTimeProgressionStatus() == true) { // if time is moving normally / not in a special event
		alarm[0] = game_get_speed(gamespeed_fps)*lengthOfHour;
		
	}
	else {
		alarm[0] = game_get_speed(gamespeed_fps)*30;
	}
	countdownOngoing = true;
}















