// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationHandler(_fileList) : createDataHandler(_fileList) constructor {
	
	//conversationData = {}; struct to store all raw data
	//fileNames = []; list of all file names
	
	// store each node as an object and then assign types accordingly
	
	fileList = _fileList
	addFiles(fileList);
	
	currentGraph = {}; 
	messageStruct = {};
	responseStruct = {};
	secondResponseStruct = {};
	
	nodeDataStruct = {};
	
	currentNode = noone;
	currentMessage = noone;
	currentResponse = noone;
	currentSecondResponse = noone;
	
	
	static getNode = function(index) { // works
		//show_debug_message(nodeList);
		return nodeList[index];
	}
	
	static getMessage = function(node) { // works
		return currentNode.getMessage();
	}
	
	static loadDialogueNode = function(currentStruct, currentID, currentStructType) {
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
	}
	
	static loadJumpNode = function (currentStruct, currentID, currentStructType, targetNode) {
		struct_set(nodeDataStruct, currentID, targetNode);
	}

	static loadConversation = function(_fileName) { // load a given file into a graph stored inside the object
		
		var fileName = _fileName;
		var rawData = getFile(fileName)//[$ "Packages"][$ "Models"];
		rawData = rawData[$ "Packages"][0][$ "Models"]; // break down into main core
		
		for (var i = 0; i < array_length(rawData); i++) {
			
			var currentStruct = rawData[i];
			var currentStructType = currentStruct.Type;
			currentStruct = currentStruct[$ "Properties"]; // search inside another layer
			var currentID = currentStruct[$ "Id"]; // current node id
				
			if (currentStructType == "DialogueFragment") { // if its a node in the conversation graph
				currentID = currentStruct[$ "Id"]; // current node id
				loadDialogueNode(currentStruct, currentID, currentStructType);	
			}
			
		}
		
		for (var i = 0; i < array_length(rawData); i++) {
			
			var currentStruct = rawData[i];
			var currentStructType = currentStruct.Type;
			currentStruct = currentStruct[$ "Properties"]; // search inside another layer
			var currentID = currentStruct[$ "Id"]; // current node id

			if (currentStructType == "Jump") {
				var targetID = currentStruct[$ "Target"];
				var targetNode = nodeDataStruct[$ targetID];
			
				loadJumpNode(currentStruct, currentID, currentStructType, targetNode);
				
			}
			
		}
		
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
			}

			//else if (getType(node) == "Jump"
		}
	return;
	}
		
	static advanceGraph = function (newNode) {
		currentNode = newNode;
		loadCurrentNodeData(currentNode);
		show_debug_message(currentNode.getMessage())
	}

}