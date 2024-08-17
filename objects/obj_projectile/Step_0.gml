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
		// check direction at which wall was collided with
		var xDirection = collisionInstance.x - x;
		var yDirection = collisionInstance.y - y;
		var newAngle = 0;
		if (abs(yDirection) > abs(xDirection)) { // if the bullet is coming from either on top or below
			if ((yDirection < 0 && image_angle < 180 && image_angle > 0)) {
				newAngle = mirrorAngleAlongYAxis((image_angle+180)%360);
				show_debug_message("BELOW HIT");
			}
			else if (yDirection > 0 && image_angle <= 360 && image_angle >= 180) {
				newAngle = mirrorAngleAlongYAxis((image_angle+180)%360);
				show_debug_message("TOP HIT");
			}
			// +180 to flip side, then mirror across y axis
		}
		else if (abs(xDirection) > abs(yDirection)) { // if bullet is coming from left or right
				newAngle = (mirrorAngleAlongYAxis(image_angle));
				show_debug_message("SIDE HIT");
		}
		else {
			show_debug_message("CORNER CASE");
		}
		if (random_range(1, 2) > 1.5) {
			newAngle = (newAngle+5)%360;
		}
		else {
			newAngle = (newAngle-5)%360;
		}
		show_debug_message([image_angle, newAngle]);
		image_angle = newAngle; 
		direction = newAngle;
		startCollisionBuffer();
		// set reflect angle accordingly
	}
	else if (projectileData.checkWallCollision() == false) {
		instance_destroy(self);
	}
}

/*if (place_meeting(x, y, obj_wall)) { // WALL MUST BE ROTATED ACCORDINGLY
	show_message("REFACTOR STUPID");
	if (projectileData.checkWallCollision() == true) {
		var instance = instance_place(x, y, obj_wall);
		var newAngle = abs(angle_difference(image_angle, instance.image_angle)) + instance.image_angle;
		if (newAngle == image_angle) {
			instance_destroy(self);
		}
		else {
		image_angle = newAngle; 
		direction = newAngle;
		x += lengthdir_x(10, newAngle);
		y += lengthdir_y(10, newAngle);
		show_debug_message(newAngle);
		}
	}
	else {
		instance_destroy(self);
	}	
}

if (place_meeting(x, y, obj_deadZone)) {
	instance_destroy(self);
}
*/






