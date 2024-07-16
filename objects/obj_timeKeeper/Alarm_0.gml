/// @description advances the game time by 1 tick
// You can write your code in this editor

global.timeKeeper.moveTimeForward();
countdownOngoing = false;
global.timeKeeper.startPulse();
alarm[1] = 2; 
show_debug_message(global.timeKeeper.currentTime)
// send pulse for 1 frame













