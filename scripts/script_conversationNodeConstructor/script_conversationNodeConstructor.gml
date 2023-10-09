// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationNode(_nodeID, _childList, _type) constructor { 
	
	// universal attributes of nodes; id, parent, child
	nodeID = _nodeID;
	childList = _childList;
	type = _type;
	
	getNodeID = function() {
		return nodeID;
	}
	
	getType = function() {
		return type;
	}
	
	getChildList = function() {
		return childList;
	}
}

function createDialogueNode (_nodeID, _childList, _type, _currentMessage, _currentResponse, _currentSecondResponse) :  createConversationNode(_nodeID, _childList, _type) constructor {
	currentMessage = _currentMessage;
	currentResponse = _currentResponse;
	currentSecondResponse = _currentSecondResponse;
	
	getMessage = function() {
		return currentMessage;
	}
	
	getResponse = function() {
		if (nodeID == noone) {
			return noone;
		}
		else {
			return currentResponse;
		}
	}
	
	getSecondResponse = function() {
		return currentSecondResponse;
	}
}