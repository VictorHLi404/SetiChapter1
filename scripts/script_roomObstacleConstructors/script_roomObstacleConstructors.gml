// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function moveAndPlace(objectData) { // placed in step, take in an instance of a PuzzleObject and check for interactions w grid
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
		if (mouse_check_button(mb_left)) {
			if (gridInstance != noone) {
				var positionData = variable_instance_get(gridInstance, "puzzleGrid").snapToPosition(mouse_x, mouse_y);
				x = positionData[0];
				y = positionData[1];
				var gridData = variable_instance_get(gridInstance, "puzzleGrid");
				if (gridData.isGridCellEmpty(positionData[0], positionData[1])) {
					var newGeneratedObject = instance_create_layer(positionData[0], positionData[1], "Instances", self.object_index);
					gridData.placeInGrid(positionData[0], positionData[1], newGeneratedObject);	
					if (objectData.getIsLevelEditor() != true) { // bruh
						global.placingInProgress = false;
						instance_destroy(self);
					}
				}
			}

		}
	}
}

function levelEditorEvaluateStopFollowing(objectData) {
	if (keyboard_check_pressed(ord("Q")) && objectData.getIsLevelEditor()) {
		if (objectData.isFollowingMouse()) {
			objectData.setFollowingMouse(false);
			global.placingInProgress = false;
			instance_destroy(self);
		}	
	}	
}

function createPuzzleObject(_type, _x, _y, _imageAngle, _active, _isLevelEditor) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor { 
	isLevelEditor = _isLevelEditor;
	canBePlaced = false;
	static getIsLevelEditor = function() {
		return isLevelEditor;
	}
	
	static updateIsLevelEditor = function(boolean) {
		isLevelEditor = boolean;
	}
	
	static getCanBePlaced = function() {
		return canBePlaced;
	}
	
	static updateCanBePlaced = function(boolean) {
		canBePlaced = boolean;
	}
}


function createRoomWall(_type, _x, _y, _imageAngle, _active, _isLevelEditor) : createPuzzleObject(_type, _x, _y, _imageAngle, _active, _isLevelEditor) constructor { 

	static toString = function() {
		return [type, xPosition, yPosition, imageAngle, active];
	}
}

function createPlayerRoomWall(_type, _x, _y, _imageAngle, _active, _isLevelEditor) : createPuzzleObject(_type, _x, _y, _imageAngle, _active, _isLevelEditor) constructor { 

	static toString = function() {
		return [type, xPosition, yPosition, imageAngle, active];
	}
}


function createEndZone(_type, _x, _y, _imageAngle, _active, _isLevelEditor) : createPuzzleObject(_type, _x, _y, _imageAngle, _active, _isLevelEditor) constructor { 
	
	static toString = function() {
		return [type, xPosition, yPosition, imageAngle, active];
	}
	
}

function createDeadZone(_type, _x, _y, _imageAngle, _active, _isLevelEditor) : createPuzzleObject(_type, _x, _y, _imageAngle, _active, _isLevelEditor) constructor { 
	
	static toString = function() {
		return [type, xPosition, yPosition, imageAngle, active];
	}
}