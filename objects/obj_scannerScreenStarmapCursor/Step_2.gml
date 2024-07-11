/// @description Insert description here
// You can write your code in this editor

if (position_meeting(mouse_x, mouse_y, obj_starmapOverlay)) {
	if (!isPlaced) {
		obj_scannerScreenCursor.setIsHidden(true);
		if (abs(x-mouse_x) >= movementTolerance) {
			if (mouse_x > 0 + edgeDistance && mouse_x < widthBox - edgeDistance) {
					x = mouse_x;
			}
		}
		if (abs(y-mouse_y) >= movementTolerance) {
			if (mouse_y > 0 + edgeDistance && mouse_y < heightBox - edgeDistance) {
					y = mouse_y;
			}
		}
	}
	else {
		obj_scannerScreenCursor.setIsHidden(false);
	}
}
else {
	obj_scannerScreenCursor.setIsHidden(false);
}




















