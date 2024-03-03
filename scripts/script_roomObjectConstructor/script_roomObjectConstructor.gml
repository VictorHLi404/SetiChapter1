// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createRoomObject(_type, _x, _y, _imageAngle, _active){
	type = _type; // name for obbject
	xPosition = _x;
	yPosition = _y;
	imageAngle = _imageAngle; // rotation of object going COUNTER CLOCKWISE 
	active = _active; // WHETHER OBJECT IS CONSIDERED ACTIVE OR NOT
	
	

}


function createRoomWall(_type, _x, _y, _imageAngle, _active) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor { 
	
	
	static toString = function() {
		var array = [5];
		array[0] = type;
		array[1] = xPosition;
		array[2] = yPosition;
		array[3] = imageAngle;
		array[4] = active;
		return array;
		
	}
}