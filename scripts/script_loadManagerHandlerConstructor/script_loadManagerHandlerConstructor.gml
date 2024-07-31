// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createLoadManagerHandler(_fileList) : createDataHandler(_fileList) constructor {
	networkLayoutData = fileData[$ fileNames[0]]; // struct, contains the existing layout of the management
	subprocessRepository = fileData[$ fileNames[1]]; // struct, contaisn all subprocess data to refer to when creating new object 
	networkLayoutReference = {}; // easy way to access nodes to loop over / retrieve for data
	
	blankCell = new createProcessingCell("BlankCell", -1000, -1000, 0, false, new createSubprocess("","","","",0));
	
	masterBonusTracker = new createBonusCounter();
	
	static decompileNodeJSON = function(JSONStruct) { // for decompiling node json
		var dataArray = [];
		dataArray[0] = JSONStruct[$ "NetworkNodeID"];
		dataArray[1] = JSONStruct[$ "IsActive"];
		dataArray[2] = JSONStruct[$ "GridWidth"];
		dataArray[3] = JSONStruct[$ "GridHeight"];
		dataArray[4] = JSONStruct[$ "PrerequisiteNodes"];
		dataArray[5] = JSONStruct[$ "InternalGrid"];
		return dataArray;
	}
	
	static decompileSubprocessJSON = function(JSONStruct) { // for decompiling subprocess json
		var dataArray = [];
		dataArray[0] = JSONStruct[$ "SubprocessID"];
		dataArray[1] = JSONStruct[$ "SubprocessName"];
		dataArray[2] = JSONStruct[$ "SubprocessDescription"];
		dataArray[3] = JSONStruct[$ "SubprocessType"]
		dataArray[4] = JSONStruct[$ "SubprocessEffect"];
		return dataArray;
	}
	
	static initializeNetwork = function() { // O(n)^3 run time, watch out
		var nodeNames = struct_get_names(networkLayoutData);
		var networkLength = struct_names_count(networkLayoutData);
		for (var i = 0; i < networkLength; i++) {
			var currentNodeData = decompileNodeJSON(networkLayoutData[$ nodeNames[i]]); 
			var gridWidth = currentNodeData[2];
			var gridHeight = currentNodeData[3];
			var internalStoredGrid = currentNodeData[5];
			var newNetworkNode = new createNetworkNode("NetworkNode", 0, 0, 0, currentNodeData[1], currentNodeData[0], currentNodeData[2], currentNodeData[3], currentNodeData[4]);
			for (var j = 0; j < gridHeight; j++) { // might need to swap order
				for (var k = 0; k < gridWidth; k++) {
					if (internalStoredGrid[j][k] == "BlankCell") {
						newNetworkNode.loadIntoGrid(j, k, blankCell);
					}
					else {
						var subprocessData = decompileSubprocessJSON(subprocessRepository[$ internalStoredGrid[j][k]]);
						var newSubprocess = new createSubprocess(subprocessData[0], subprocessData[1], subprocessData[2], subprocessData[3], subprocessData[4]);
						var newCell = new createProcessingCell(subprocessData[0], -1000, -1000, 0, false, newSubprocess);
						newNetworkNode.loadIntoGrid(j, k, newCell);
					}
				}
			}
			networkLayoutReference[$ currentNodeData[0]] = newNetworkNode;
			// POTENTIALLY erase networklayoutdata here if memory becomes an issue
		}
	}
	
	static getNodeFromID = function(nodeID) { // returns networkNode object
		return networkLayoutReference[$ nodeID];
	}
	
	static getBlankCell = function() {
		return blankCell;
	}
	
	static calculateBonuses = function() { // loop through all bonus object sin each grid, add to master list
		var nodeNames = struct_get_names(networkLayoutReference);
		var networkLength = struct_names_count(networkLayoutReference);
		for (var i = 0; i < networkLength; i++) {
			var currentNode = networkLayoutReference[$ nodeNames[i]];
			if (currentNode.getNodeName() == "T1") {
				//show_message("RAM NODE")
				continue;
			}
			if (!currentNode.getIsActive()) {
				//show_message(currentNode.getNodeName() + " DISABLED");
				continue;
			}
			var currentNodeBonuses = currentNode.getNodeBonuses();
			masterBonusTracker.combineBonusCounter(currentNodeBonuses);
		}
		//show_message(masterBonusTracker);
	}
	
	static isNodeActivationValid = function(networkNode) { // loop through node list, check if aall are active, return boolean
		var prerequisiteNodeList = networkNode.getPrerequisiteNodes();
		for (var i = 0; i < array_length(prerequisiteNodeList); i++) {
			var prerequisiteNode = networkLayoutReference[$ prerequisiteNodeList[i]];
			if (!prerequisiteNode.getIsActive()) {
				return false;
			}
			if (prerequisiteNode.containsCorruptedCell()) {
				//show_message(prerequisiteNode.getNodeName() + "  CONTAINS CORRUPT CELL");
				return false;
			}
		}
		show_message("SET " + networkNode.getNodeName() + " TO ACTIVE");
		return true;
	}
	
	static deleteFromNetwork = function(cellID) { // loop through node list, find specific location, delete
		var nodeNames = struct_get_names(networkLayoutReference);
		var length = struct_names_count(networkLayoutReference);
		for (var i = 0; i < length; i++) {
			var networkNode = networkLayoutReference[$ nodeNames[i]];
			if (networkNode.containsCell(cellID)) {
				networkNode.deleteFromGrid(cellID);
			}
		}
	}
	
	static beginFixingNode = function(cellID) {
		var nodeNames = struct_get_names(networkLayoutReference);
		var length = struct_names_count(networkLayoutReference);
		for (var i = 0; i < length; i++) {
			var networkNode = networkLayoutReference[$ nodeNames[i]];
			if (networkNode.containsCell(cellID)) {
				networkNode.repairCellInGrid(cellID);
				global.taskHandler.loadCorruptedNodeTask(cellID);
			}
		}		
	}
	
	static evaluateInProgressNodes = function() {
		var nodeNames = struct_get_names(networkLayoutReference);
		var length = struct_names_count(networkLayoutReference);
		for (var i = 0; i < length; i++) {
			var networkNode = networkLayoutReference[$ nodeNames[i]];
			if (networkNode.containsCorruptedCell()) {
				var corruptedArray = networkNode.getCorruptedCells();
				//show_debug_message(corruptedArray);
				for (var j = 0; j < array_length(corruptedArray); j++) {
					var cellID = corruptedArray[j].getType();
					if (global.taskHandler.isCorruptedNodeComplete(cellID)) {
						networkNode.deleteFromGrid(cellID);
					}
				}
				
			}
		}
	}
	

}