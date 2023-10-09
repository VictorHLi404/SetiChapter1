// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationHandler(_fileList) : createDataHandler(_fileList) constructor {
	
	//conversationData = {}; struct to store all raw data
	//fileNames = []; list of all file names
	
	// store each node as an object and then assign types accordingly
	
	fileList = _fileList
	addFiles(fileList);
	
	currentGraph = {}; 
	nodeTypeStruct = {};
	messageStruct = {};
	responseStruct = {};
	secondResponseStruct = {};
	
	nodeDataStruct = {};
	
	currentNode = noone;
	currentMessage = noone;
	currentResponse = noone;
	currentSecondResponse = noone;
	
	currentSelect = noone;
	
	leftNode = noone;
	leftResponse = noone;
	leftSecondResponse = noone;
	midNode = noone;
	midResponse = noone;
	midSecondResponse = noone;
	rightNode = noone;
	rightResponse = noone;
	rightSecondResponse = noone;
	
	nodeList = [leftNode, midNode, rightNode];
	responseList = [leftResponse, midResponse, rightResponse];
	secondResponseList = [leftSecondResponse, midSecondResponse, rightSecondResponse];
	
	static getType = function(currentNode) { // works
		return nodeTypeStruct[$ currentNode];
	}
	
	static getNode = function(index) { // works
		//show_debug_message(nodeList);
		return nodeList[index];
	}
	
	static getResponse = function(nodeID) { // works
		if (nodeID != noone) {
			return nodeID.getResponse()
		}
		else {
			return noone;	
		}
	}
	
	static getMessage = function(node) { // works
		return currentNode.getMessage();
	}

	static loadConversation = function(_fileName) { // load a given file into a graph stored inside the object
		
		var fileName = _fileName;
		var rawData = getFile(fileName)//[$ "Packages"][$ "Models"];
		rawData = rawData[$ "Packages"][0][$ "Models"]; // break down into main core
		
		for (var i = 0; i < array_length(rawData); i++) {
			
			var currentStruct = rawData[i];
			var currentStructType = currentStruct.Type;

			
			currentStruct = currentStruct[$ "Properties"]; // search inside another node
			
			var currentID = currentStruct[$ "Id"]; // current node id
			struct_set(nodeTypeStruct, currentID, currentStructType);
				
			if (currentStructType == "DialogueFragment") { // if its a node in the conversation graph
				
				var outputPins = currentStruct[$ "OutputPins"][0]; 
				var currentMessage = currentStruct[$ "Text"]; // current node main text
				var currentResponse = currentStruct[$ "MenuText"]; // current node response
				var currentSecondResponse = currentStruct[$ "StageDirections"]; // current node secondary text
				
				var currentIDOptions = []; // list to store next nodes in graph
				
				// ----------------------------------------- load connecting nodes into graph ----------
				
				for (var j = 0; j < array_length(outputPins[$ "Connections"]); j++) {
					array_push(currentIDOptions, outputPins[$ "Connections"][j][$ "Target"]);
				}
				
				struct_set(nodeDataStruct, currentID, new createDialogueNode(currentID, currentIDOptions, currentStructType, currentMessage, currentResponse, currentSecondResponse));
				//show_debug_message(nodeDataStruct);
				
				struct_set(currentGraph, currentID, currentIDOptions);
				
				// load current id messsage, response, and secondary response
				
				struct_set(messageStruct, currentID, currentMessage);
				struct_set(responseStruct, currentID, currentResponse);
				struct_set(secondResponseStruct, currentID, currentSecondResponse);
				
			}
		}
		/*
		show_debug_message("CURRENT GRAPH")
		show_debug_message(currentGraph);
		show_debug_message("MESSAGES")
		show_debug_message(messageStruct);
		show_debug_message("RESPONSES");
		show_debug_message(responseStruct);
		show_debug_message("SECONDARY")
		show_debug_message(secondResponseStruct);
		*/
		return;
	}

	static initializeConversation = function() { // initialize conversation by given start node
		
		var IDList = struct_get_names(nodeDataStruct);
		
		for (var i = 0; i < array_length(IDList); i++) { // find the starting point of the conversation\
			var currentSearchID = IDList[i];
			if (nodeDataStruct[$ currentSearchID].getResponse() == "START") {
				currentNode = nodeDataStruct[$ currentSearchID];
				break;
			}
		}
		// load data for the first node
		loadCurrentNodeData(currentNode);

	
	}
	
	static loadCurrentNodeData = function (currentNode) {
		currentMessage = currentNode.getMessage()
		currentResponse = currentNode.getResponse()
		currentSecondResponse = currentNode.getSecondResponse()
		loadResponses(currentNode);
	}
	
	static loadResponses = function (currentNode) {
		var responseNodeList = currentNode.getChildList()
		//var responseNodeList = currentGraph[$ currentNode];
		
		for (var i = 0; i < 3; i++) {
			nodeList[i] = noone;
		}
			
		
		for (var i = 0; i < array_length(responseNodeList); i++) {
			var tempNode = nodeDataStruct[$ responseNodeList[i]];
			show_debug_message(tempNode);
			if (tempNode.getType() == "DialogueFragment") {
				nodeList[i] = tempNode;
				responseList[i] = tempNode.getResponse();
				secondResponseList[i] = tempNode.getSecondResponse();
			}

			//else if (getType(node) == "Jump"
		}
		
		unpackResponseData(nodeList, responseList, secondResponseList);
		
	return;
	}
	
	static unpackResponseData = function (nodeList, responseList, secondResponseList) {
		unpackNodeList(nodeList);
		unpackResponseList(responseList);
		unpackSecondResponseList(secondResponseList);
		
	}
	
	static unpackNodeList = function (nodeList) {
		leftNode = nodeList[0];
		midNode = nodeList[1];
		rightNode = nodeList[2];
	}
	
	static unpackResponseList = function (responseList) {
		leftResponse = responseList[0];
		midResponse = responseList[1];
		rightResponse = responseList[2];
	}
	
	static unpackSecondResponseList = function(secondResponseList) {
		leftSecondResponse = secondResponseList[0];
		midSecondResponse = secondResponseList[1];
		rightSecondResponse = secondResponseList[2];
	
	}
		
	static advanceGraph = function (newNode) {
		currentNode = newNode;
		loadCurrentNodeData(currentNode);
		show_debug_message(currentNode.getMessage())
		show_debug_message(responseList)
		show_debug_message(secondResponseList);
	}

}