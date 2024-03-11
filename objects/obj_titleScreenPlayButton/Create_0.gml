/// @description creating struct that contains draw data
// You can write your code in this editor

text = "PLAY";
buttonID = self;
dataHandler = obj_titleScreenDataHandler.dataHandler;
template = "titleScreenButtonTemplate.json";

button = new createButton(x, y, sprite_width, sprite_height, text,  dataHandler, template, buttonID);





