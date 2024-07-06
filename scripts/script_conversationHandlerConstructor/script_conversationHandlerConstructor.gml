// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationHandler(_fileList, _npcFileName, _playerFileName) : createDataHandler(_fileList) constructor {
	
	//fileList = []; list of all file names
	//fileList[0] for conversation handlers WILL ALWAYS BE 
	
	// store each node as an object and then assign types accordingly
	fileList = _fileList;
	npcFileName = _npcFileName;
	playerFileName = _playerFileName;
	addFiles(fileList); // super call from data handler
	
	currentNPC = new createNPC(self, npcFileName); // refers to the object that contains all of the stats + known information of the npc currently in conversation, can check and update values
	playerData = new createNPC(self, playerFileName); // player data is handled the same as npc, so just do it and its fine
	nodeDataStruct = {}; // ACTUALLY IMPORTANT, constains the name / id of a node and its actual node data struct
	nodeList = []; // contains the potential pathways from current node, raw node data
	currentNode = noone; // contains the current nodes DATA, so not nodeID but the actual raw data
	
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
				
		for (var i = 0; i < array_length(outputPins[$ "Connections"]); i++) {
			array_push(currentIDOptions, outputPins[$ "Connections"][i][$ "Target"]);
		}
		struct_set(nodeDataStruct, currentID, new createDialogueNode(currentID, currentIDOptions, currentStructType, currentMessage, currentResponse, currentSecondResponse, currentResponseEffect));
		// ---------------------------------------------------------------------------------------------------------------------------------
	}
	
	static loadConditionalNode = function(currentStruct, currentID, currentStructType) {
		var outputPins = currentStruct[$ "OutputPins"]; 
		var currentIDOptions = []; // list to store next nodes in graph
		var conditionalStatement = currentStruct[$ "DisplayName"];
		
		for (var i = 0; i < array_length(outputPins); i++) { // STRUCTURED DIFFERENTLY FROM DIALOGUE NODE
			array_push(currentIDOptions, outputPins[i][$ "Connections"][0][$ "Target"]);
		}
		struct_set(nodeDataStruct, currentID, new createConditionalNode(currentID, currentIDOptions, currentStructType, conditionalStatement));
	}
	
	static loadJumpNode = function (currentStruct, currentID, currentStructType) { // NOT CURRENTLY WORKING, 
		//should load the given node into the conversatoin currently stored within the handler by looking towards the jump pin
		var targetID = currentStruct[$ "Target"];
		var currentIDOptions = []; // fucked up the design, so just insert blank target node list to fill in stuff
		struct_set(nodeDataStruct, currentID, new createJumpNode(currentID, currentIDOptions, currentStructType, targetID));
	}
	
	static loadConversation = function(_fileName) { // load a given file into a graph stored inside the object
		
		var fileName = _fileName;
		var rawData = getFile(fileName);
		rawData = rawData[$ "Packages"][0][$ "Models"]; // break down into main core
		
		for (var i = 0; i < array_length(rawData); i++) {
			
			var currentStruct = rawData[i]; 
			var currentStructType = currentStruct.Type; // type of the node
			currentStruct = currentStruct[$ "Properties"]; // search inside another layer
			var currentID = currentStruct[$ "Id"]; // current node id
				
			if (currentStructType == "DialogueFragment") { // if its a regular dialogue node in the conversation graph
				currentID = currentStruct[$ "Id"]; // current node id, FIX FOR REDUNDANCY
				loadDialogueNode(currentStruct, currentID, currentStructType);	
			}
			if (currentStructType == "Condition") { // if its a conditional node
				currentID = currentStruct[$ "Id"];
				loadConditionalNode(currentStruct, currentID, currentStructType);
			}
			if (currentStructType == "Jump") {
				currentID = currentStruct[$ "Id"];
				loadJumpNode(currentStruct, currentID, currentStructType);
			}
		}
		return;
	}
	
	static readStateChange = function(expressionString) { // used to update the main 3 stats + change any variables based off of tghe statements made
		var affectedEntity = isNPCData(expressionString, currentNPC, playerData); // entity used to declare whether it should be the npc being updated or the player data file
		expressionString = pruneStatement(expressionString);
		// determines whether it is setting a variable / flagging something or updating something new
		
		if (string_contains("+=", expressionString) || string_contains("-=", expressionString)) { // IF the staeement is to UPDATE an integer value
			var valueName = pullStatNameFromStatement(expressionString);  // agreeability, trust, fear
			var valueInteger = pullIntegerFromStatement(expressionString); // number to update the stat by
			
			if (string_contains("+=", expressionString)) { // if adding to value
				affectedEntity.updateIntegerValue(valueName, valueInteger);
			}
			else if (string_contains("-=", expressionString)) { // if taking away
				affectedEntity.updateIntegerValue(valueName, valueInteger*-1);
			}
			show_message(affectedEntity.getAgreeability());
		}
		else if (string_contains("=", expressionString)) { // if the statement is to change a boolean value
			var flagName = pullFlagNameFromStatement(expressionString);
			var flagBoolean = pullFlagBooleanFromStatement(expressionString);
			affectedEntity.updateBooleanValue(flagName, flagBoolean);
		}
	}
	
	static evaluateIfStatement = function(conditionalNode) { // used to evalute choices at conditional node, GENERAL FUNCTION USED FOR BOTH BOOLEAN AND INTEGER, returns a node id
		//  use the functions to check if its a numerical stat check
		// pull related necessary parameters
		// check true false, return
		var expressionString = conditionalNode.getConditionalStatement();
		var affectedEntity = isNPCData(expressionString, currentNPC, playerData); // entity used to declare whether it should be the npc being updated or the player data file
		expressionString = pruneStatement(expressionString);
		var isAIntegerIfStatement = containsInteger(expressionString);
		
		if (isAIntegerIfStatement) {
			var statName = pullStatNameFromStatement(expressionString);
			var equalityType = pullEqualityTypeFromStatement(expressionString);
			var value = pullIntegerFromStatement(expressionString);
			
			if (affectedEntity.evaluateIntegerValue(statName, equalityType, value) == true) {
				show_message("CONDITIONAL PASSED");
				return conditionalNode.getTrueOption();
			}
			else {
				show_message("CONDITIONAL FAILED");
				return conditionalNode.getFalseOption();
			}
		}
		else { // assume it is a boolean check
			var flagName = pullFlagNameFromStatement(expressionString);
			if (affectedEntity.evaluateBooleanConditional(flagName) == true) {
				show_message("CONDITIONAL PASSED");
				return conditionalNode.getTrueOption();
			}
			else {
				show_message("CONDITIONAL FAILED");
				return conditionalNode.getFalseOption();
			}
		}
	}
	
	static loadCurrentNodeData = function (currentNode) { // load the dialogue node of the current data into the handler so that the handler can display message, response, second response, and next responses
		currentMessage = currentNode.getMessage();
		currentResponse = currentNode.getResponse();
		currentSecondResponse = currentNode.getSecondResponse();
		loadResponses(currentNode);
	}
	
	static recursiveLoadNode = function(currentNode) { // returns node, recursiely searches through the data structure till it hits an endpoint
		show_message(currentNode.getType());
		if (currentNode.getType() == "DialogueFragment" || currentNode.getType() == "Jump") {
			return currentNode;
		}
		return recursiveLoadNode(nodeDataStruct[$ evaluateIfStatement(currentNode)]);
		
	}
	
	static clearNodeList = function() {
		for (var i = 0; i < 3; i++) { // null the current NodeList set by the handler
			nodeList[i] = noone;
		}
	}
	
	static saveConversationChanges = function() {
		show_message("SAVING NPC CHANGES");
		readStateChange(currentNode.getCurrentResponseEffect()); // get last effect of the last 
		fileData[$ currentNPC.getFileName()] = currentNPC.recompileIntoJSON();
		fileData[$ playerData.getFileName()] = playerData.recompileIntoJSON();
		saveFiles();
	}

	static advanceGraph = function (newNode) { // sets a new currentNode according to a given newNode, accessed by the conversation buttons
		//	REWORK TO MAKE IT BASED OFF OF INDEX RATHER THAN RAW NODE DATA
		readStateChange(currentNode.getCurrentResponseEffect());
		currentNode = newNode;
		loadCurrentNodeData(currentNode);
		return;
	}
	
	static loadEndNode = function(endNode) { // add extra functionality later to make it possible for loading / saving
		show_message(currentNode.getMessage());
		advanceGraph(endNode);

		saveConversationChanges();
		return;
	}
	
	static loadSkipNode = function(skipNode) {
		show_message(currentNode.getMessage());
		advanceGraph(skipNode);
		return;
	}
	
	static getJumpNodeTarget = function(jumpNode) {
		return nodeDataStruct[$ jumpNode.getTargetID()];
	}

	static loadResponses = function (currentNode) { // loads the responses of the current node into the handler so that the recieving buttons can display / update accordingly
		var responseNodeList = currentNode.getChildList();
		clearNodeList();
	
		for (var i = 0; i < array_length(responseNodeList); i++) { // ALGORITHM to evaluate stats to load responses accordingly goes here, takes in list of node IDs and generates list of nodes
			var tempNode = nodeDataStruct[$ responseNodeList[i]];
			//show_debug_message(tempNode);
			if (tempNode.getType() == "DialogueFragment") { // EVAULATE FOR SKIP / END
				nodeList[i] = tempNode;
			}
			else if (tempNode.getType() == "Condition") {
				var endpointNode = recursiveLoadNode(tempNode); // recursively search through if statements entil reaching endpoint of dialogue or jump node
				if (endpointNode.getType() == "DialogueFragment") {
					nodeList[i] = endpointNode;
				}
				else if (endpointNode.getType() == "Jump") {
					nodeList[i] = getJumpNodeTarget(endpointNode);
				}
			}
			else if (tempNode.getType() == "Jump") {
				nodeList[i] = getJumpNodeTarget(tempNode);
			}
		}
		// EVAULATE FOR SKIP / END, if the childlist only has one destination and contains a SKIP/END, advacne to that node and replace the child list again
		if (array_length(responseNodeList) == 1 && nodeList[0].getResponse() == "SKIP") {
			show_message("SKIP ENABLED")
			loadSkipNode(nodeList[0]);
			return;
		}
		else if (array_length(responseNodeList) == 1 && nodeList[0].getResponse() == "END") {
			show_message("END OF CONVERSATION REACHED")
			loadEndNode(nodeList[0]);
			return;
		}
		return;
	}
	
	static initializeConversation = function() { // initialize conversation by given start node
		
		var IDList = struct_get_names(nodeDataStruct);
		
		for (var i = 0; i < array_length(IDList); i++) { // find the starting point of the conversation
			var currentSearchID = IDList[i];
			if (nodeDataStruct[$ currentSearchID].getType() == "DialogueFragment") {
				if (nodeDataStruct[$ currentSearchID].getResponse() == "START") { // identify the current start node
					currentNode = nodeDataStruct[$ currentSearchID];
					break;
				}
			}
		}
		// load data for the first node
		loadCurrentNodeData(currentNode);
	
	}
}