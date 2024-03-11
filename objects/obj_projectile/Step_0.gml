/// @description Insert description here
// You can write your code in this editor


if (place_meeting(x, y, obj_wall)) { // WALL MUST BE ROTATED ACCORDINGLY
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






