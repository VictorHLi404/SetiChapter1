/// @description Insert description here
// You can write your code in this editor

global.conversationProfileHandler = new createConversationProfileHandler(["ProfileStack.json"]);
global.conversationProfileHandler.initializeStack();
global.conversationProfileHandler.loadNewConversations(global.timeKeeper.getCurrentTime());
isActive = false; // whether its counting ticks to update new things
isDisplayActive = false; // whether its sending display updates to the task displays

alarm[0] = 2;



















