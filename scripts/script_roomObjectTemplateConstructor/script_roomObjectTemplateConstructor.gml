// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createRoomObject(_type, _x, _y, _imageAngle, _active) constructor { // template used for all physical / on screen elements
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
	
	static getX = function() {
		return xPosition;
	}
	
	static getY = function() {
		return yPosition;
	}
	
	static getImageAngle = function() {
		return imageAngle;
	}
	
	static updateImageAngle = function (newAngle) {
		imageAngle = newAngle;
	}
	
}