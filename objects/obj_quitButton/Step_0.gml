if (position_meeting(mouse_x, mouse_y, obj_quitButton) and (obj_cursor.sprite_index == spr_cursor) and global.currentFocus == noone) {
	global.currentFocus = obj_quitButton;
}

