// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function createRoomWall(_type, _x, _y, _imageAngle, _active) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor { 

	static toString = function() {
		return [type, xPosition, yPosition, imageAngle, active];
	}
}

function createEndZone(_type, _x, _y, _imageAngle, _active, _width, _height) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor {
	width = _width;
	height = _height;
	win = false;
	
	static setWin = function(state) {
		win = state;
	}
	static toString = function() {
		return [type, xPosition, yPosition, imageAngle, active, width, height];
	}
	
}

function createDeadZone(_type, _x, _y, _imageAngle, _active, _width, _height) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor {
	width = _width;
	height = _height;
	
	static toString = function() {
		return [type, xPosition, yPosition, imageAngle, active, width, height];
	}
}