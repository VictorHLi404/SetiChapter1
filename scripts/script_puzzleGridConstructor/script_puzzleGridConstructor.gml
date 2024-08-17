// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createPuzzleGrid(_type, _x, _y, _imageAngle, _active, _width, _height, _cellSize, _isLevelEditor) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor {
	gridWidth = _width;
	gridHeight = _height;
	cellSize = _cellSize;
	isLevelEditor = _isLevelEditor;
	internalGrid = [gridWidth][gridHeight];
	
	
	static blankInitialize = function() {
		for (var i = 0; i < gridWidth; i++) {
			for (var j = 0; j < gridHeight; j++) {
				internalGrid[i][j] = noone;
			}
		}
	}
	
	static resetGrid = function() {
		for (var i = 0; i < gridWidth; i++) {
			for (var j = 0; j < gridHeight; j++) {
				if (internalGrid[i][j] != noone) {
					instance_destroy(internalGrid[i][j]);
				}
				internalGrid[i][j] = noone;
			}
		}
	}
	
	static cleanPlayerInstances = function() { // go through entire grid and remove any playermade objects
		for (var i = 0; i < gridWidth; i++) {
			for (var j = 0; j < gridHeight; j++) {
				if (internalGrid[i][j] == noone) {
					continue;
				}
				var objectType = variable_instance_get(internalGrid[i][j], "objectData").getType();
				if (string_contains("PLAYERMADE_", objectType)) {
					instance_destroy(internalGrid[i][j]);
					internalGrid[i][j] = noone;
				}
			}
		}
	}
	
	
	static snapToPosition = function(_x, _y) { // take in position of element hovering over it, snap to the grid, called if there is an overlap
		var newXPosition = floor((_x - xPosition)/cellSize)*cellSize + xPosition + cellSize/2;
		var newYPosition = floor((_y - yPosition)/cellSize)*cellSize + yPosition + cellSize/2;
		return [newXPosition, newYPosition];
	}
	
	static loadIntoGrid = function(horizontalIndex, verticalIndex, puzzleObject) {
		internalGrid[verticalIndex][horizontalIndex] = puzzleObject;
		return;
	}
	
	static areGridCoordinatesWithinBounds = function(gridX, gridY) {
		if (gridX < 0 || gridX >= gridWidth || gridY < 0 || gridY >= gridHeight) {
			return false;
		}
		else {
			return true;
		}
	}
	
	static isGridCellEmpty = function(_x, _y) {
		var gridX = floor((_x - xPosition)/cellSize);
		var gridY = floor((_y - yPosition)/cellSize);
		if (!areGridCoordinatesWithinBounds(gridX, gridY)) {
			return false;
		}
		/*if (gridX < 0 || gridX >= gridWidth || gridY < 0 || gridY >= gridHeight) {
			return false;
		}*/
		if (internalGrid[gridX][gridY] == noone) {
			return true;
		}
		else {
			return false;
		}
	}
	
	static placeInGrid = function(_x, _y, puzzleObject) { // take in position of element hovering over it, snap in
		var gridX = floor((_x - xPosition)/cellSize);
		var gridY = floor((_y - yPosition)/cellSize);
		if (isGridCellEmpty(_x, _y)) {
			internalGrid[gridX][gridY] = puzzleObject;
			show_debug_message(puzzleObject.objectData.getType() + " PLACED IN " + string(gridX) + " " + string(gridY));
		}
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
		show_debug_message([gridX, gridY]);
		if (!areGridCoordinatesWithinBounds(gridX, gridY)) {
			return;
		}
		instance_destroy(internalGrid[gridX][gridY]);
		internalGrid[gridX][gridY] = noone;
		return;
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
	
	static getInternalGrid = function() {
		return internalGrid;
	}
	
	static getIsLevelEditor = function() {
		return isLevelEditor;
	}
	
	static updateIsLevelEditor = function(boolean) {
		isLevelEditor = boolean;
		return;
	}
}
