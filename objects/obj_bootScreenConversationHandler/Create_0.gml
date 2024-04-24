/// @description Insert description here
// You can write your code in this editor


conversationHandler = new createConversationHandler(["WC_intro.json", "WilliamCheung.json"], "WilliamCheung.json");
conversationHandler.loadConversation(conversationHandler.fileList[0]);
conversationHandler.initializeConversation();
show_message("CONVERSATION HANDLER INITIALIZATION COMPLETE")











