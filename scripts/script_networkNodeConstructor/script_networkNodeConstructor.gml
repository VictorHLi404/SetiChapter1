// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createNetworkNode(_type, _x, _y, _imageAngle, _active, _nodeName, _gridWidth, _gridHeight, _prerequisiteNodes) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor {
	// inherit "active" to be used from RoomObjectTemplate
	nodeName = _nodeName;
	gridWidth = _gridWidth;
	gridHeight = _gridHeight;
	cellSize = 40; // standard, hunt down to change later if buggy
	prerequisiteNodes = _prerequisiteNodes; // list of previous nodes that need to be "active" for the current node to work
	blankCell = global.loadManagerHandler.getBlankCell();
	
	internalGrid = [gridWidth][gridHeight]; // 2 d array to store the resulting variables
	currentBonuses = new createBonusCounter();
	
	static updateNodeName = function(newName) {
		nodeName = newName;
	}
	
	static getNodeName = function() {
		return nodeName;
	}
	
	static getPrerequisiteNodes = function() {
		return prerequisiteNodes;
	}
	
	static updateGridWidthAndHeight = function(newWidth, newHeight) {
		gridWidth = newWidth;
		gridHeight = newHeight;
	}
	
	static getGridWidth = function() {
		return gridWidth;
	}
	
	static getGridHeight = function() {
		return gridHeight;
	}
	
	static getGridCell = function(horizontalIndex, verticalIndex) {
		return internalGrid[verticalIndex][horizontalIndex];
	}
	
	static loadIntoGrid = function(horizontalIndex, verticalIndex, cellData) {
		internalGrid[verticalIndex][horizontalIndex] = cellData;
		return;
	}
	
	static snapToPosition = function(_x, _y) { // take in position of element hovering over it, snap to the grid, called if there is an overlap
		var newXPosition = floor((_x - xPosition)/cellSize)*cellSize + xPosition + cellSize/2;
		var newYPosition = floor((_y - yPosition)/cellSize)*cellSize + yPosition + cellSize/2;
		return [newXPosition, newYPosition];
	}
	
	static placeInGrid = function(_x, _y, cellData) { // take in position of element hovering over it, snap in
		var gridX = floor((_x - xPosition)/cellSize);
		var gridY = floor((_y - yPosition)/cellSize);
		cellData.updateNodeType(getNodeName(), string(gridX), string(gridY));
		show_message(cellData.getType());
		internalGrid[gridX][gridY] = cellData;
		return;
	}
	
	static getGridCoordinates = function(horizontalIndex, verticalIndex) { // returns positional data for generated files from save
		var xCoord = horizontalIndex*cellSize + xPosition + cellSize/2;
		var yCoord = verticalIndex*cellSize + yPosition + cellSize/2;
		return [xCoord, yCoord];
	}
	
	static emptyCellInGrid = function(_x, _y) { // take position of element existing inside of it, delete from array
		var gridX = floor((_x - xPosition)/cellSize);
		var gridY = floor((_y - yPosition)/cellSize);
		internalGrid[gridX][gridY] = blankCell;
		return;
	}
	
	static emptyCellInGridIndex = function(horizontalIndex, verticalIndex) {
		internalGrid[horizontalIndex][verticalIndex] = blankCell;
		return;
	}
	
	static getNodeBonuses = function() { // loop through all valid nodes, sum up their effects
		currentBonuses = new createBonusCounter();
		for (var i = 0; i < gridWidth; i++) {
			for (var j = 0; j < gridHeight; j++) {
				if (!internalGrid[i][j].isBlank() && internalGrid[i][j].isFunctionalCell()) {
					var subprocessBonuses = internalGrid[i][j].getSubprocessBonuses(); // [type, effect];
					currentBonuses.updateBonuses(subprocessBonuses);
				}
			}
		}
		return currentBonuses;
	}
	
	static containsCorruptedCell = function() { // loop through to detect if any corrupted/inprogress nodes, use to detemrine whether to activate next ones
		for (var i = 0; i < gridWidth; i++) {
			for (var j = 0; j < gridHeight; j++) {
				if (!internalGrid[i][j].isValidCell()) {
					return true;
				}
			}
		}
		return false;
	}
	
	static getCorruptedCells = function() { // loop through and collect all corrupted/inprogress nodes, then get IDs
		var corruptedArray = [];
		for (var i = 0; i < gridWidth; i++) {
			for (var j = 0; j < gridHeight; j++) {
				if (!internalGrid[i][j].isValidCell()) {
					array_push(corruptedArray, internalGrid[i][j]);
				}
			}
		}
		return corruptedArray;
	}
	
	static containsCell = function(cellID) { // loop through and match cell ID 
		for (var i = 0; i < gridWidth; i++) {
			for (var j = 0; j < gridHeight; j++) {
				if (internalGrid[i][j].getType() == cellID) {
					return true;
				}
			}
		}
		return false;
	}
	
	static deleteFromGrid = function(cellID) { // loop through grid, find cellID, delte data and kill the instance
		for (var i = 0; i < gridWidth; i++) {
			for (var j = 0; j < gridHeight; j++) {
				if (internalGrid[i][j].getType() == cellID) {
					show_message(string(i) + " " + string(j));
					emptyCellInGridIndex(i, j);
					var cellInstance = instance_position(xPosition + i*cellSize + cellSize/2, yPosition + j*cellSize + cellSize/2, obj_processingCell);
					if (cellInstance != noone) {
						instance_destroy(cellInstance);
					}
					else {
						show_message("MISSED");
					}
				}
			}
		}
	}
	
	static searchGrid = function(cellID) { // loop through grid, return [horizontalIndex, verticalIndex] of position
		for (var i = 0; i < gridWidth; i++) {
			for (var j = 0; j < gridHeight; j++) {
				if (internalGrid[i][j].getType() == cellID) {
					return [i, j];
				}
			}
		}
		return [-1, -1] // return crash values if not present
	}
	
	static repairCellInGrid = function(cellID) {
		var cellIndex = searchGrid(cellID);
		var cellData = internalGrid[cellIndex[0]][cellIndex[1]];
		cellData.setCorruptedToInProgress();
	}
	
}