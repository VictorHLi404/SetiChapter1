/// @description Insert description here
// You can write your code in this editor

text = "";
buttonPosition = "LEFT";
buttonID = obj_bootScreenLeftChoice;
dataHandler = obj_bootScreenDataHandler.dataHandler;
conversationHandler = obj_bootScreenConversationHandler.conversationHandler;
template = "bootScreenButtonTemplate.json";

button = new createConversationButton(x, y, sprite_width, sprite_height, text, dataHandler, template, buttonID, buttonPosition, conversationHandler);





