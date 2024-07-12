/// @description Insert description here
// You can write your code in this editor

isPlaced = false; // variable to keep it still or not
canBeMoved = true; // alarm variable to make it so that someone cant instantly pick up and put down the thing
movementTolerance = 20; // tick value 
heightBox = obj_starmapOverlay.sprite_height;
widthBox = obj_starmapOverlay.sprite_width;
edgeDistance = sprite_width/2;

starmapCursor = new createRoomObject("StarmapCursor", x, y, image_angle, true);

function getIsPlaced() {
	return isPlaced;
}

function setCanBeMoved(state) {
	canBeMoved = state;
}

function getDataObject() {
	return starmapCursor;
}




















