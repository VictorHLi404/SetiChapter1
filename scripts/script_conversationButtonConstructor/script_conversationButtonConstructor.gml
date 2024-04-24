// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationButton (_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID, _buttonPosition, _conversationHandler) : createButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID) constructor {
	buttonPosition = _buttonPosition; // string that determines the "position" of the choice among the 3 possibilities
	conversationHandler = _conversationHandler; // reference to the conversation handler in the room
	nodeID = noone; // NOT ACTUAL ID, fucked up the name, contains the raw Dialogue/ConversationNode
	
	static updateNodeID = function() { // constantly runs inside of step function to pull 
		nodeID = getNodeID(buttonPosition);
	}
	
	static getNodeID = function(buttonPosition) { // returns the raw data construct with the node and its information so that the button can call upon it to get information
		
		var index = global.INT_MAX;
		
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
	
	static getTextResponse = function() { // placed inside of step function of button object, constantly updates to update the text contained within the button based off of the node
		if (nodeID != noone) {
		text = nodeID.getResponse();
		}
		else {
			text = noone;
		}
	}
	
	static advanceConversation = function() { // placed inside of step function of button object, triggers when clicked to advance conversation based on choice
		conversationHandler.advanceGraph(nodeID);
	}
	
	return;
}