/// @description Insert description here
// You can write your code in this editor

dataHandler = obj_globalDataHandler.dataHandler;
countdownOngoing = false; // variable to check if a tick is currently counting down
lengthOfHour = 1; // length of hour in real time seconds CHANGE TO MODIFY THE ENTIRE THING
initialized = false;
global.timeKeeper = new createTimeKeeper(dataHandler);
global.timeKeeper.loadCurrentTime();
alarm[2] = 10;










