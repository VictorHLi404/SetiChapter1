text = "CONVERSATION";
buttonID = "ConversationScreenButton";
dataHandler = obj_centralHubDataHandler.dataHandler;
template = "centralHubScreenButtonTemplate.json";

button = new createButton(x, y, sprite_width, sprite_height, text,  dataHandler, template, buttonID);

function uniqueButtonEvent() {
	room_goto(room_conversationHubScreen);
}