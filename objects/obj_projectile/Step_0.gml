/// @description Insert description here
// You can write your code in this editor

var collisionInstance = instance_place(x, y, objectArray);
if (collisionInstance != noone) {
	var collisionObjectType = collisionInstance.object_index;
	if (collisionObjectType == obj_deadZone) {
		instance_destroy(self);
	}
	/// assume that its a wall collision from here
	if (projectileData.checkWallCollision() == true && !collisionBuffer) { // enough bounces to bounce	
		var newAngle = distortAngle(calculateBounceAngle(image_angle, x, y, collisionInstance.x, collisionInstance.y));
		image_angle = newAngle; 
		direction = newAngle;
		startCollisionBuffer();
		// set reflect angle accordingly
	}
	else if (projectileData.checkWallCollision() == false) { // no more bounces left
		instance_destroy(self);
	}
}
