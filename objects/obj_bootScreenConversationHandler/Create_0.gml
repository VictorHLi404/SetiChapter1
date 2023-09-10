/// @description Insert description here
// You can write your code in this editor


conversationHandler = new createConversationHandler(["AB_bootSequence.json"]);
conversationHandler.loadConversation(conversationHandler.fileList[0]);
conversationHandler.initializeConversation();
show_debug_message("INITIALIZATION COMPLETE")











