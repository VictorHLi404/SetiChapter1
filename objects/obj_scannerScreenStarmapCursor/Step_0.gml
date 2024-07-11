if (position_meeting(mouse_x, mouse_y, obj_starmapOverlay)) {
	if (!isPlaced && mouse_check_button_pressed(mb_left)) {
		isPlaced = true;
		canBeMoved = false;
		alarm[0] = 3 // CHANGE TO BE HOWEVER LONG THE SIGNAL PING IS
	}
}

if (position_meeting(mouse_x, mouse_y, self) && canBeMoved && mouse_check_button_pressed(mb_left)) {
	isPlaced = false;
}

