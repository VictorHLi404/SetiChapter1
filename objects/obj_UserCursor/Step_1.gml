/// @description Insert description here
// You can write your code in this editor

if (global.left or global.right or global.up or global.down) { // if a keyboard movement button has been pressed, mute/invis the cursor
	//object_set_sprite(obj_bootScreenCursor, spr_noCollision);
	sprite_index = spr_noCollision;
}

x = mouse_x;
y = mouse_y;

if ((mouseX != x || mouseY != y)) { // if the mouse is moved again, then reshow the cursor
	if (!isHidden) {
		sprite_index = spr_cursor;
		//object_set_sprite(obj_bootScreenCursor, spr_cursor);
		global.currentFocus = noone;
	}
	else { // assume another cursor has taken over
		sprite_index = spr_noCollision;
	}
}
mouseX = x;
mouseY = y;














