/// @description Insert description here
// You can write your code in this editor


if (wallData.isFollowingMouse() == true) { // 32 IS GRID SIZE
	
	x = floor((mouse_x/32))*32;
	y = floor((mouse_y/32))*32;
	wallData.updateXY(mouse_x, mouse_y);
	
	if (keyboard_check_pressed(vk_right)) { // ROTATION
		var newAngle = image_angle + 90;
		if (newAngle > 360) {
			newAngle = newAngle%360;
		}
		image_angle = newAngle;
		wallData.updateImageAngle(newAngle);
	}
	
	if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) {
		if (!place_meeting(x, y, all)) {
			wallData.setFollowingMouse(false);
			global.placingInProgress = false;
		}
	}
}







