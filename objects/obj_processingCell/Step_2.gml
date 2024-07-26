/// @description Insert description here
// You can write your code in this editor


/*if (mouse_check_button_pressed(mb_left)) {
	if (cellData.isFollowingMouse() && global.placingInProgress == false) { // picking up from cell
		show_message("PICK UP");
		pickupX = x;
		pickupY = y;
		var gridInstance = instance_place(x, y, obj_networkNode);
		if (gridInstance != noone) {
			var gridData = variable_instance_get(gridInstance, "networkNode");
			gridData.emptyCellInGrid(x, y);
		}
		obj_globalInputHandler.staggerDefaultInput();
	}
	if (!cellData.isFollowingMouse() && global.placingInProgress == true) { // placing cell inside of something
		show_message("PUT DOWN");
		var gridInstance = instance_place(x, y, obj_networkNode);
		if (gridInstance != noone) {
			if (!place_meeting(x, y, obj_processingCell)) {
				var gridData = variable_instance_get(gridInstance, "networkNode");
				gridData.placeInGrid(x, y, cellData);
			}
			else {
				show_message("ITEM ALREADY EXISTS IN SLOT");
				x = pickupX;
				y = pickupY;
			}
		}
		else {
			x = pickupX;
			y = pickupY;
		}
		obj_globalInputHandler.staggerDefaultInput();
	}
}*/






















