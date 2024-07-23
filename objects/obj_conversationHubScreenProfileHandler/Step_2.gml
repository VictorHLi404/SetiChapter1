/// @description Insert description here
// You can write your code in this editor

if (global.timeKeeper.isPulseOngoing()) {
	global.conversationProfileHandler.loadNewConversations(global.timeKeeper.getCurrentTime());
	global.conversationProfileHandler.updateConversationStandbyQueue();
	global.conversationProfileHandler.progressTime();
	global.conversationProfileHandler.evaluateTimeEligbility();
	global.conversationProfileHandler.loadConversationsIntoProfile();
}























