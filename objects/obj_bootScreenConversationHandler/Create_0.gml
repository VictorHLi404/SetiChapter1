/// @description Insert description here
// You can write your code in this editor


conversationHandler = new createConversationHandler(["PlayerData.json", global.conversationProfileHandler.getCurrentNPCToLoad(),  global.conversationProfileHandler.getCurrentConversationToLoad()], global.conversationProfileHandler.getCurrentNPCToLoad(), "PlayerData.json");
conversationHandler.loadConversation(conversationHandler.fileList[2]);
conversationHandler.initializeConversation();
show_message("CONVERSATION HANDLER INITIALIZATION COMPLETE")











