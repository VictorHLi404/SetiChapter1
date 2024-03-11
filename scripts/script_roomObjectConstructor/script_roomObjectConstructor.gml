// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createRoomObject(_type, _x, _y, _imageAngle, _active){
	type = _type; // name for obbject
	xPosition = _x;
	yPosition = _y;
	imageAngle = _imageAngle; // rotation of object going COUNTER CLOCKWISE 
	active = _active; // WHETHER OBJECT IS CONSIDERED ACTIVE OR NOT
	followingMouse = false; // WHETHER OBJECT IS CURRENTLY BEING DRAGGED / PLACED BY MOUSE
	
	static isFollowingMouse = function() {
		return followingMouse;
	}
	
	static setFollowingMouse = function(state) {
		followingMouse = state;
		if (state == true) {
			active = false;
		}
		else {
			active = true;
		}
	}
	
	static setType = function(_type) {
		type = _type; 
	}
	
	static getType = function() {
		return type;
	}

	static updateXY = function(_x, _y) {
		xPosition = _x;
		yPosition = _y;
	}
	
	static updateImageAngle = function (_imageAngle) {
		imageAngle = _imageAngle;
	}
	

}


function createRoomWall(_type, _x, _y, _imageAngle, _active) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor { 
	
	
	static toString = function() {
		return [type, xPosition, yPosition, imageAngle, active];
	}
}

// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
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