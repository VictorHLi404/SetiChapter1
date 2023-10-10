// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationTextDisplay(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _conversationHandler) : createTextDisplay(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile) constructor {
	conversationHandler = _conversationHandler;
	nodeID = noone;
	
	static updateNodeID = function() {
		nodeID = conversationHandler.currentNode;
		//show_debug_message(nodeID);
	}
	
	updateNodeID();
	static getTextMessage = function() {
		text = nodeID.getMessage();
	}
	
}