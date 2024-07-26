/// @description Insert description here
// You can write your code in this editor

if (currentSubprocessType != cellData.getCurrentSubprocess().getSubprocessType()) {
	updateCellSprite();
	currentSubprocessType = cellData.getCurrentSubprocess().getSubprocessType();
}

if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, self)) {
	
	obj_cellDataDisplay.updateCellDataDisplay(cellData);
	
	if (!cellData.isFollowingMouse() && global.placingInProgress == false && cellData.isValidCell()) { // picking up from cell
		pickupX = x;
		pickupY = y;
		var gridInstance = instance_place(x, y, obj_networkNode);
		if (gridInstance != noone) {
			var gridData = variable_instance_get(gridInstance, "networkNode");
			gridData.emptyCellInGrid(x, y);
		}
		cellData.setFollowingMouse(true);
		obj_globalInputHandler.staggerDefaultInput();
	}
	
	if (cellData.isFollowingMouse() && global.placingInProgress == true && cellData.isValidCell()) { // placing cell inside of something
		var gridInstance = instance_place(x, y, obj_networkNode);
		if (gridInstance != noone) {
			if (!place_meeting(x, y, obj_processingCell)) {
				var gridData = variable_instance_get(gridInstance, "networkNode");
				gridData.placeInGrid(x, y, cellData);
			}
			else {
				x = pickupX;
				y = pickupY;
			}
		}
		else {
			x = pickupX;
			y = pickupY;
		}
		cellData.setFollowingMouse(false);
		obj_globalInputHandler.staggerDefaultInput();
	}
}

if (cellData.isFollowingMouse()) {
	var gridInstance = instance_place(x, y, obj_networkNode);
	if (gridInstance != noone) { // if inisde of grid, snap to poisition
		var positionData = variable_instance_get(gridInstance, "networkNode").snapToPosition(mouse_x, mouse_y);
		show_debug_message(positionData);
		x = positionData[0];
		y = positionData[1];
	}
	else { // follow mouse 
		x = mouse_x;
		y = mouse_y;
	}

}























