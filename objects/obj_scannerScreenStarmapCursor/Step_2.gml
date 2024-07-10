/// @description Insert description here
// You can write your code in this editor

if (position_meeting(mouse_x, mouse_y, obj_starmapOverlay)) {
	if (!isPlaced) {
		obj_scannerScreenCursor.setIsHidden(true);
		show_debug_message(obj_scannerScreenCursor.isHidden);
		object_set_sprite(obj_scannerScreenCursor, spr_noCollision);
		if (abs(x-mouse_x) >= movementTolerance) {
			x = mouse_x;
		}
		if (abs(y-mouse_y) >= movementTolerance) {
			y = mouse_y;
		}
	}
}




















