// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createNetworkNode(_type, _x, _y, _imageAngle, _active, _gridWidth, _gridHeight) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor {
	gridWidth = _gridWidth;
	gridHeight = _gridHeight;
	cellSize = 40; // standard, hunt down to change later if buggy
	
	internalGrid = [gridWidth][gridHeight]; // 2 d array to store the resulting variables
	
	static getGridWidth = function() {
		return gridWidth;
	}
	
	static getGridHeight = function() {
		return gridHeight;
	}
	
	static snapToPosition = function(_x, _y) { // take in position of element hovering over it, snap to the grid, called if there is an overlap
		var newXPosition = floor((_x - xPosition)/cellSize)*gridWidth + xPosition;
		var newYPosition = floor((_y - yPosition)/cellSize)*gridHeight + yPosition;
		return [newXPosition, newYPosition];
	}
	
	static placeInGrid = function(_x, _y) { // take in position of element hoverin over it, snap in
 	
	}
}