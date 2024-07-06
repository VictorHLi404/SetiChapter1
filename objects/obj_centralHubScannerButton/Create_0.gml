/// @description Insert description here
// You can write your code in this editor

text = "SCANNER";
buttonID = self;
dataHandler = obj_centralHubDataHandler.dataHandler;
template = "centralHubScreenButtonTemplate.json";

button = new createButton(x, y, sprite_width, sprite_height, text,  dataHandler, template, buttonID);