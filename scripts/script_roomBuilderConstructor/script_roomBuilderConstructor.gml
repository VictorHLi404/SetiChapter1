// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createRoomBuilder(_fileList) : createDataHandler(_fileList) constructor {
	// CURRENT ROOM DATA; ROOM THAT IS CURRENTLY BEING MODIFIED / ON DISPLAY
	// ROOMDATA: DATA TO PULL FOR ALL ITERATIONS
	
	objectMap = {
		"WALL" : obj_wall,
		"DEADZONE" : obj_deadZone,
		"ENDZONE" : obj_endZone,
		"ERASER" : obj_eraser,
		"PLAYERSHOOTER": obj_playerShooter,
		"BLANK": noone
	};
	
	static getRoomDataFromFile = function(sourceFile) {
		var dataStruct = getFile(sourceFile);
		var nameGrid = dataStruct[$ "RoomData"];
		return nameGrid;
	}
	
	static getRoomDataFromPuzzleCode = function(puzzleCode) {
		var dataStruct = getFile("PuzzleRepository.json");
		var nameGrid = dataStruct[$ puzzleCode][$ "PuzzleData"][$ "RoomData"];
		return nameGrid;
	}
	
	static getPuzzleObjectFromName = function(objectName) {
		return objectMap[$ objectName];
	}

}