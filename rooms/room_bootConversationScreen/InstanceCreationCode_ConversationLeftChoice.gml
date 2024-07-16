text = "";
buttonPosition = "LEFT";
buttonID = "ConversationButtonLeftChoice";
dataHandler = obj_bootScreenDataHandler.dataHandler;
conversationHandler = obj_bootScreenConversationHandler.conversationHandler;
template = "bootScreenButtonTemplate.json";

button = new createConversationButton(x, y, sprite_width, sprite_height, text, dataHandler, template, buttonID, buttonPosition, conversationHandler);