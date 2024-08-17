// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createPuzzleRoomScanner(_fileList) : createDataHandler(_fileList) constructor {
	dataList = {};
	
	objectToNameMap = {
		obj_wall : "WALL",
		obj_deadZone : "DEADZONE",
		obj_endZone : "ENDZONE",
		obj_playerShooter : "PLAYERSHOOTER",
		noone : "BLANK"
	}
	
	static saveCurrentRoom = function(objectGrid, gridWidth, gridHeight) {
		var nameGrid = [gridWidth][gridHeight];
		for (var i = 0; i < gridWidth; i++) {
			for (var j = 0; j < gridHeight; j++) {
				if (objectGrid[i][j] == noone) {
					nameGrid[i][j] = "BLANK";
					continue;
				}
				// if it gets too fat try to implement map again, but shit dont work
				var objectID = objectGrid[i][j].object_index;
				if (objectID == obj_wall) {
					nameGrid[i][j] = "WALL";
				}
				else if (objectID == obj_deadZone) {
					nameGrid[i][j] = "DEADZONE";
				}
				else if (objectID == obj_endZone) {
					nameGrid[i][j] = "ENDZONE";
				}
				else if (objectID == obj_playerShooter) {
					nameGrid[i][j] = "PLAYERSHOOTER";
				}
			}
		}	
		dataList[$ "RoomData"] = nameGrid;
	}
	
	static saveLevelEditorFile = function() {
		saveFiles();
	}
	
	static saveToJSON = function (fileName) {
		JSONSave(fileName, dataList);
	}
	
	static updateObjectGrid = function(newGrid) {
		objectGrid = newGrid;
	}
}