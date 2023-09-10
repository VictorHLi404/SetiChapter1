// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationButton (_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID, _buttonPosition, _conversationHandler) : createButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID) constructor {
	buttonPosition = _buttonPosition;
	conversationHandler = _conversationHandler;
	nodeID = noone;
	
	static setNodeID = function() {
		return getNodeID(buttonPosition);
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
		return conversationHandler.getNodeID(index);
	}
	
	nodeID = setNodeID();
	
	static getTextResponse = function() {
		text = conversationHandler.getResponse(nodeID);
	}
	return;
}