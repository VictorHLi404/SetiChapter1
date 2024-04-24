/// @description Insert description here
// You can write your code in this editor

currentTickTime = global.timeKeeper.getCurrentTime(); // time on clock progresses display by hour, go from 0-23 in a loop
dataHandler = obj_centralHubDataHandler.dataHandler;
template = "centralHubScreenButtonTemplate.json";

clock = new createClock(currentTickTime%24);
textBox = new createTextDisplay(x, y, sprite_width, sprite_height, clock.getTimeString(), dataHandler, template);











