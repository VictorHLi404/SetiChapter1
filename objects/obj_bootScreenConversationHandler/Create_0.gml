/// @description Insert description here
// You can write your code in this editor


conversationHandler = new createConversationHandler(["WC_intro.json", "WilliamCheung.json", "DS_intro.json", "PlayerConversationData.json", "DM_intro.json", "DanielMiya.json"], "DanielMiya.json", "PlayerConversationData.json");
conversationHandler.loadConversation(conversationHandler.fileList[0]);
conversationHandler.initializeConversation();
show_message("CONVERSATION HANDLER INITIALIZATION COMPLETE")











