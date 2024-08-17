/// @description Insert description here
// You can write your code in this editor

saveButtonInstance = noone;
testButtonInstance = noone;
roomScanner = new createPuzzleRoomScanner(["currentLevelEditorDesign.json"]);

function saveCurrentRoom() {
	var gridInstance = instance_find(obj_puzzleGrid,0);
	var gridData = variable_instance_get(gridInstance, "puzzleGrid");
	var objectGrid = gridData.getInternalGrid();
	roomScanner.saveCurrentRoom(objectGrid, gridData.getGridWidth(), gridData.getGridHeight());
	roomScanner.saveToJSON("currentLevelEditorDesign.json");
}

function createSaveButtonInstance() {
	var saveButtonID = "SaveCurrentRoomButton";
	var saveButton = new createButton(30, 30, 180, 120, "SAVE", global.displayHandler, global.displayHandler.getDebugTemplate(), saveButtonID);
	saveButtonInstance = instance_create_layer(30, 30, "Instances", obj_button);

	with (saveButtonInstance) {
		button = saveButton;
		buttonID = saveButtonID;
		depth = -1000;
		image_xscale = 2.81;
		image_yscale = 1.875;
		uniqueButtonEvent = function() {
			obj_roomScanner.saveCurrentRoom();
		}
	}
}

function createTestButtonInstance() {
	var testButtonID = "TestCurrentRoomButton";
	var testButton = new createButton(240, 30, 180, 120, "TEST", global.displayHandler, global.displayHandler.getDebugTemplate(), testButtonID);
	testButtonInstance = instance_create_layer(240, 30, "Instances", obj_button);
	with (testButtonInstance) {
		button = testButton;
		buttonID = testButtonID;
		depth = -1000;
		image_xscale = 2.81;
		image_yscale = 1.875;
		uniqueButtonEvent = function() {
			obj_roomScanner.saveCurrentRoom();
			room_goto(room_levelTesterScreen);
		}	
	}
}

createSaveButtonInstance();
createTestButtonInstance();