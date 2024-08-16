// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createPuzzleObjectSpawner(_type, _isLevelEditor, _objectCurrentCount) constructor {
	
	type = _type;
	isLevelEditor = _isLevelEditor;
	objectCurrentCount = _objectCurrentCount;
	
	spriteMap = {
		"BLANK" : spr_blankSpawner,
		"WALL" : spr_wallSpawner,
		"DEADZONE" : spr_deadzoneSpawner,
		"ENDZONE" : spr_endzoneSpawner,
		"ERASER" : spr_eraserIcon,
		"PLAYERSHOOTER": spr_playerShooterSpawner
	};
	
	objectMap = {
		"WALL" : obj_wall,
		"DEADZONE" : obj_deadZone,
		"ENDZONE" : obj_endZone,
		"ERASER" : obj_eraser,
		"PLAYERSHOOTER": obj_playerShooter
	};
	
	static updateType = function(newType) {
		type = newType;
	}
	
	static getSprite = function() { // map of type names to sprite file, use inside of object to update
		return spriteMap[$ type];
	}
	
	static getObject = function() { // same thing, map of type names to object id
		return objectMap[$ type];
	}
	
	static spawnObject = function () {
		objectCurrentCount--;
	}
	
	static canObjectSpawn = function() {
		if (isLevelEditor) {
			return true;
		}
		if (objectCurrentCount > 0) {
			return true;
		}
		else {
			return false;
		}
	}
	
	static getIsLevelEditor = function() {
		return isLevelEditor;
	}
}