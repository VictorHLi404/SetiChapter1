if (position_meeting(mouse_x, mouse_y, obj_optionsButton) and (obj_cursor.sprite_index == spr_cursor) and global.currentFocus == noone) {
	global.currentFocus = obj_optionsButton;
	show_debug_message(object_get_sprite(obj_cursor))
}
