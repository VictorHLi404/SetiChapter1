/// @description Insert description here
// You can write your code in this editor

if (global.timeKeeper.isPulseOngoing()) {
	var currentTime = global.timeKeeper.getCurrentTime();
	if (currentTime % 24 == 0) {
		show_message("REGENERATING ATTEMPT");
		global.puzzleHandler.regenerateAttempt();
	}
}























