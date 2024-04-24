/// @description Insert description here
// You can write your code in this editor

if (global.timeKeeper.isPulseOngoing()) {
	show_debug_message("TIMEKEEPER PULSE TRIGGERED");
	clock.advanceTime();
	textBox.updateText(clock.getTimeString());
}














