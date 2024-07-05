// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function createConversationNode(_nodeID, _childList, _type) constructor { 
	
	// universal attributes of nodes; id, parent, child
	nodeID = _nodeID; // ID of the current node
	childList = _childList; // nodes that the current node points towards / can be travelled to
	type = _type; // type of node it is
	
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

function createDialogueNode (_nodeID, _childList, _type, _currentMessage, _currentResponse, _currentSecondResponse, _currentResponseEffect) :  createConversationNode(_nodeID, _childList, _type) constructor { // FIGURE OUT WHY I MADE THIS???
	currentMessage = _currentMessage;
	currentResponse = _currentResponse;
	currentSecondResponse = _currentSecondResponse;
	currentResponseEffect = _currentResponseEffect;
	getMessage = function() {
		return currentMessage;
	}
	
	getResponse = function() { // check if node is a valid node before returning data
		if (nodeID == noone) {
			return noone;
		}
		else {
			return currentResponse;
		}
	}
	
	getSecondResponse = function() {
		if (nodeID == noone) {
			return noone;
		}
		else {
			return currentSecondResponse;
		}
		
	}
	
	static getCurrentResponseEffect = function() {
		if (currentResponseEffect == "") {
			return noone;
		}
		else {
			return currentResponseEffect;
		}
	}
}

function createConditionalNode(_nodeID, _childList, _type, _conditionalStatement) : createConversationNode(_nodeID, _childList, _type) constructor { // adaptive node that when reached in the dialogue, should automatically redirect to something new
	conditionalStatement = _conditionalStatement;
	trueOption = _childList[0];
	falseOption = _childList[1];
	
	getConditionalStatement = function() { // returns string
		return conditionalStatement;
	}
	
	getTrueOption = function() { // returns nodeID
		return trueOption;
	}
	
	getFalseOption = function() { // return nodeID
		return falseOption;
	}
	
	// MAKE THE ASSUMPTION THAT THE "TRUE" OPTION OR OPTION THAT PASSES THE CONDITIONAL STATEMENT IS INDEX 0, AND FALESE IN INDEX 1
}

function createJumpNode(_nodeID, _childList, _type, _targetID) : createConversationNode(_nodeID, _childList, _type) constructor {
	targetID = _targetID;
	
	getTargetID = function() {
		return targetID;
	}
}
