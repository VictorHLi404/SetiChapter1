// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function moveAndErase(objectData) { // use for eraser, get cell object and delete
	if (objectData.isFollowingMouse()) { // movement function, USE FOR ALL OBJECTS
		var gridInstance = instance_place(x, y, obj_puzzleGrid);
		if (gridInstance != noone) { // if inisde of grid, snap to poisition
			var positionData = variable_instance_get(gridInstance, "puzzleGrid").snapToPosition(mouse_x, mouse_y);
			x = positionData[0];
			y = positionData[1];
		}
		else { // follow mouse 
			x = mouse_x;
			y = mouse_y;
		}
		if (objectData.getIsLevelEditor() == true) {
			if (mouse_check_button(mb_left)) {
				if (gridInstance != noone) {
					var positionData = variable_instance_get(gridInstance, "puzzleGrid").snapToPosition(x, y);
					x = positionData[0];
					y = positionData[1];
					var gridData = variable_instance_get(gridInstance, "puzzleGrid");
					gridData.emptyCellInGrid(positionData[0], positionData[1]);
				}
				else {
					show_debug_message("CONTACTING NOTHING");
				}
			}
		}
	}
}

function checkResetGrid() {
	if (keyboard_check_pressed(ord("R"))) {
		var gridInstance = instance_place(x, y, obj_puzzleGrid);
		if (gridInstance != noone) {
			var gridData = variable_instance_get(gridInstance, "puzzleGrid");
			gridData.resetGrid();
		}

	}
}

function createEraser(_type, _x, _y, _imageAngle, _active, _isLevelEditor) : createPuzzleObject(_type, _x, _y, _imageAngle, _active, _isLevelEditor) constructor {

}