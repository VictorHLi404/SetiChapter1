/// @description Insert description here
// You can write your code in this editor

roomBuilder = new createRoomBuilder(["currentLevelEditorDesign.json"]);

function loadCurrentRoom() {
	var gridInstance = instance_find(obj_puzzleGrid,0);
	var gridData = variable_instance_get(gridInstance, "puzzleGrid");
	var nameGrid = roomBuilder.getRoomData("currentLevelEditorDesign.json");
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

loadCurrentRoom();




