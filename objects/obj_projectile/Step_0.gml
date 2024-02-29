/// @description Insert description here
// You can write your code in this editor


if (place_meeting(x, y, obj_wall)) { // WALL MUST BE ROTATING ACCORDINGLY
	var instance = instance_place(x, y, obj_wall);
	var newAngle = abs(angle_difference(image_angle, instance.image_angle)) + instance.image_angle;
	image_angle = newAngle;
	direction = newAngle
	show_debug_message(newAngle);
	
}







