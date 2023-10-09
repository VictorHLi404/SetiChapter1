// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationButton (_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID, _buttonPosition, _conversationHandler) : createButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID) constructor {
	buttonPosition = _buttonPosition;
	conversationHandler = _conversationHandler;
	nodeID = noone;
	
	static updateNodeID = function() {
		nodeID = getNodeID(buttonPosition);
	}
	
	static getNodeID = function(buttonPosition) {
		
		var index = noone;
		
		if (buttonPosition == "LEFT") {
			index = 0;
		}
		else if (buttonPosition == "MIDDLE") {
			index = 1;
		}
		else if (buttonPosition == "RIGHT") {
			index = 2;
		}
		return conversationHandler.getNode(index);
	}
	
	nodeID = updateNodeID();
	
	static getTextResponse = function() {
		if (nodeID != noone) {
		text = nodeID.getResponse();
		}
		else {
			text = noone;
		}
	}
	
	static advanceConversation = function() {
		conversationHandler.advanceGraph(nodeID);
	}
	return;
}