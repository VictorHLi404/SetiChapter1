/// @description Insert description here
// You can write your code in this editor


conversationHandler = new createConversationHandler(["WC_intro.json", "WilliamCheung.json", "DS_intro.json", "PlayerData.json", "DM_intro.json", "introStatus.json", "DanielMiy.json"], "WilliamCheung.json", "PlayerData.json");
conversationHandler.loadConversation(conversationHandler.fileList[2]);
conversationHandler.initializeConversation();
show_message("CONVERSATION HANDLER INITIALIZATION COMPLETE")











