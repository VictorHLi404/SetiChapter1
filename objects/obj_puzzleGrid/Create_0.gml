/// @description Insert description here
// You can write your code in this editor

puzzleGrid = new createPuzzleGrid("LevelEditorGrid", x, y, image_angle, true, 46, 30, 30, true);
resetButtonInstance = noone;

puzzleGrid.blankInitialize();

function createResetButton() {
	var resetButtonID = "ResetCurrentRoomButton";
	var resetButton = new createButton(540, 30, 180, 120, "RESET", global.displayHandler, global.displayHandler.getDebugTemplate(), resetButtonID);
	resetButtonInstance = instance_create_layer(540, 30, "Instances", obj_button);
	with (resetButtonInstance) {
		button = resetButton;
		buttonID = resetButtonID;
		depth = -1000;
		image_xscale = 2.81;
		image_yscale = 1.875;
		uniqueButtonEvent = function() {
			obj_puzzleGrid.reloadGrid();
		}
	}
}

function updateIsLevelEditor(boolean) {
	puzzleGrid.updateIsLevelEditor(boolean);
}

function reloadGrid() {
	puzzleGrid.cleanPlayerInstances();
}

function evaluateRoomType() {
	if (puzzleGrid.getIsLevelEditor() == true) {
		createResetButton();
	}
}




















