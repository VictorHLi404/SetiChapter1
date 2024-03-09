/// @description Insert description here
// You can write your code in this editor


if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, self) && global.placingInProgress == false) {
	global.placingInProgress = true;
	var wallInstance = instance_create_layer(mouse_x, mouse_y, "Instances", obj_wall);
	with (wallInstance) {
		wallData.setFollowingMouse(true);
		sprite_index = spr_playerCreatedWall;
	}
}







