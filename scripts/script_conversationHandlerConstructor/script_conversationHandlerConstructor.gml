// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationHandler(_fileList, _npcFileName) : createDataHandler(_fileList) constructor {
	
	//fileList = []; list of all file names
	//fileList[0] for conversation handlers WILL ALWAYS BE 
	
	// store each node as an object and then assign types accordingly
	fileList = _fileList;
	npcFileName = _npcFileName;
	addFiles(fileList); // super call from data handler
	
	
	currentNPC = new createNPC(self, npcFileName); // refers to the object that contains all of the stats + known information of the npc currently in conversation, can check and update values
	
	nodeDataStruct = {}; // ACTUALLY IMPORTANT, constains the name / id of a node and its actual node data struct
	
	currentNode = noone; // contains the current nodes DATA, so not nodeID but the actual raw data
	
	// -------------------------------------------------------- SHOULD BE REDUNDANT VARIABLES
	//currentMessage = noone; // string with the current nodes NPC line
	//currentResponse = noone; // string with the current Nodes default player response
	//currentSecondResponse = noone; // string with the current nodes alternative player response
	
	
	static getNode = function(index) { // returns a node from the nodeChoices of the current node using an index (left, middle, right)
		//show_debug_message(nodeList);
		return nodeList[index];
	}
	
	static getMessage = function(node) { // returns the current string message stored within the node
		return currentNode.getMessage();
	}
	
	static loadDialogueNode = function(currentStruct, currentID, currentStructType) { // loads the given node into the conversation currently stored within the handler
		var outputPins = currentStruct[$ "OutputPins"][0]; 
		var currentMessage = currentStruct[$ "Text"]; // current node main text
		var currentResponse = currentStruct[$ "MenuText"]; // current node response
		var currentSecondResponse = currentStruct[$ "StageDirections"]; // current node secondary text
		var currentResponseEffect = outputPins[$ "Text"]; // statement effect to be evaluated when the text is hit
		var currentIDOptions = []; // list to store next nodes in graph
				
		// ----------------------------------------- load connecting nodes into graph ----------
				
		for (var j = 0; j < array_length(outputPins[$ "Connections"]); j++) {
			array_push(currentIDOptions, outputPins[$ "Connections"][j][$ "Target"]);
		}
		struct_set(nodeDataStruct, currentID, new createDialogueNode(currentID, currentIDOptions, currentStructType, currentMessage, currentResponse, currentSecondResponse, currentResponseEffect));
		// ---------------------------------------------------------------------------------------------------------------------------------
	}
	
	static loadJumpNode = function (currentStruct, currentID, currentStructType, targetNode) { // NOT CURRENTLY WORKING, 
		//should load the given node into the conversatoin currently stored within the handler by looking towards the jump pin
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
		
		for (var i = 0; i < array_length(rawData); i++) { // FIX FOR REDUNDANCY
			
			var currentStruct = rawData[i];
			var currentStructType = currentStruct.Type;
			currentStruct = currentStruct[$ "Properties"]; // search inside another layer
			var currentID = currentStruct[$ "Id"]; // current node id

			if (currentStructType == "Jump") { // test if works???
				var targetID = currentStruct[$ "Target"];
				var targetNode = nodeDataStruct[$ targetID];
			
				loadJumpNode(currentStruct, currentID, currentStructType, targetNode);
				
			}
			
		}
		
		return;
	}
	
	static initializeConversation = function() { // initialize conversation by given start node
		
		var IDList = struct_get_names(nodeDataStruct);
		
		for (var i = 0; i < array_length(IDList); i++) { // find the starting point of the conversation
			var currentSearchID = IDList[i];
			if (nodeDataStruct[$ currentSearchID].getResponse() == "START") { // identify the current start node
				currentNode = nodeDataStruct[$ currentSearchID];
				break;
			}
		}
		// load data for the first node
		loadCurrentNodeData(currentNode);
	
	}
	
	static loadCurrentNodeData = function (currentNode) { // load the node of the current data into the handler so that the handler can display message, response, second response, and next responses
		currentMessage = currentNode.getMessage();
		currentResponse = currentNode.getResponse();
		currentSecondResponse = currentNode.getSecondResponse();
		loadResponses(currentNode);
	}
	
	static loadResponses = function (currentNode) { // loads the responses of the current node into the handler so that the recieving buttons can display / update accordingly
		var responseNodeList = currentNode.getChildList();
		//var responseNodeList = currentGraph[$ currentNode];
		
		for (var i = 0; i < 3; i++) { // null the current NodeList set by the handler
			nodeList[i] = noone;
		}
			
		
		for (var i = 0; i < array_length(responseNodeList); i++) { // ALGORITHM to evaluate stats to load responses accordingly goes here
			var tempNode = nodeDataStruct[$ responseNodeList[i]];
			//show_debug_message(tempNode);
			if (tempNode.getType() == "DialogueFragment") { // 
				nodeList[i] = tempNode;
			}

			//else if (getType(node) == "Jump"
		}
	return;
	}
		
	static advanceGraph = function (newNode) { // sets a new currentNode according to a given newNode, accessed by the conversation buttons
		//	REWORK TO MAKE IT BASED OFF OF INDEX RATHER THAN RAW NODE DATA
		//INSERT FUNCTION TO READ THE STATEMENT CONTAINED WITHIN
		readStateChange(currentNode.getCurrentResponseEffect());
		currentNode = newNode;
		loadCurrentNodeData(currentNode);
	}
	
	static readStateChange = function(expressionString) { // used to update the main 3 stats + change any variables based off of tghe statements made
		expressionString = string_replace(expressionString, "gameState.", "");
		// within articy, ALL files are put underneath the namespace of gameState, plural S
		// determines whether it is setting a variable / flagging something or updating something ne
		
		if (string_contains("+=", expressionString) || string_contains("-=", expressionString)) { // IF the staeement is to UPDATE something
			var valueName = ""; // agreeability, trust, fear
			var statement = ""; // either += or -=
			var toAdd = false; // variable used to track whether to add or decrease variable by value
			var value = global.INT_MAX; // integer that the value is to be updated by
			if (string_contains("agreeability", expressionString)) {
				valueName = "agreeability";
			}
			else if (string_contains("trust", expressionString)) {
				valueName = "trust";
			}
			else if (string_contains("fear", expressionString)) {
				valueName = "fear";
			}
			
			if (string_contains("+=", expressionString)) {
				statement = "+=";
				toAdd = true;
			}
			else if (string_contains("-=", expressionString)) {
				statement = "-=";
				toAdd = false;
			}
			
			var dataArray = string_split(expressionString, statement);
			var valueString = dataArray[array_length(dataArray)-1];
			valueString = string_replace(valueString, ";", "");
			show_message(valueString); 
			
			if (toAdd) {
				currentNPC.updateValue(valueName, real(valueString));
			}
			else {
				currentNPC.updateValue(valueName, real(valueString)*-1);
			}
			
		}	
	}
}