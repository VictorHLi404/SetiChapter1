// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createObjectSpawner(_type, _objectCurrentCount) constructor {
	
	type = _type;
	objectCurrentCount = _objectCurrentCount;
	
	static canObjectSpawn = function() {
		if (objectCurrentCount > 0) {
			return true;
		}
		else {
			return false;
		}
	}
	
	static spawnObject = function () {
		objectCurrentCount--;
	}
}