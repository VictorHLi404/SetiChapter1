/// @description Insert description here
// You can write your code in this editor

dataHandler = obj_centralHubDataHandler.dataHandler;
countdownOngoing = false; // variable to check if a tick is currently counting down
lengthOfHour = 1.25; // length of hour in real time seconds

global.timeKeeper = new createTimeKeeper(dataHandler);
global.timeKeeper.loadCurrentTime();














