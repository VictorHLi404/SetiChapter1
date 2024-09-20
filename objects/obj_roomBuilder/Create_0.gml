/// @description Insert description here
// You can write your code in this editor

roomBuilder = new createRoomBuilder(["currentLevelEditorDesign.json", "PuzzleRepository.json"]);

function buildInstanceGrid(nameGrid) {
	var gridInstance = instance_find(obj_puzzleGrid,0); // only one should exist per room
	var gridData = variable_instance_get(gridInstance, "puzzleGrid");
	var gridWidth = gridData.getGridWidth();
	var gridHeight = gridData.getGridHeight();
	for (var i = 0; i < gridWidth; i++) {
		for (var j = 0; j < gridHeight; j++) {
			positionalData = gridData.getGridCoordinates(i, j); //[x, y] of where to put cell
			if (nameGrid[i][j] != "BLANK") {
				var newObject = instance_create_layer(positionalData[0], positionalData[1], "Instances", roomBuilder.getPuzzleObjectFromName(nameGrid[i][j]));
				gridData.loadIntoGrid (j, i, newObject);
			}
			else {
				gridData.loadIntoGrid(j, i, noone);
			}
		}
	}
}

function loadEditorRoom() {
	var nameGrid = roomBuilder.getRoomDataFromFile("currentLevelEditorDesign.json");
	buildInstanceGrid(nameGrid);
}

function loadGridFromPuzzleCode() { // load puzzle grid items
	var nameGrid = roomBuilder.getRoomDataFromPuzzleCode(global.puzzleHandler.getCurrentPuzzleCode());
	buildInstanceGrid(nameGrid);
}

function enableSpawners() { // loop through the items listed in the json as available, set accordingly

}

if (room == room_battleScreen) {
	loadGridFromPuzzleCode();
}





