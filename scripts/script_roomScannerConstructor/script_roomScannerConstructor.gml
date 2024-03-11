// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createRoomScanner(_objectList) constructor {
	//
	objectList = _objectList;
	dataList = {};	
	
	static saveCurrentRoom = function() {
	for (var i = 0; i < array_length(objectList); i++) {
		var instance = objectList[i];
		var nameInstance = object_get_name(instance.object_index) + " " + string(i);
		show_debug_message(object_get_name(instance.object_index));
		if (instance.object_index == obj_wall) {
			show_debug_message("SAVING WALL OBJECT");
			dataList[$ nameInstance] = instance.wallData.toString();
		}
		else if (instance.object_index == obj_endZone) {
			show_debug_message("SAVING ENDZONE OBJECT");
			dataList[$ nameInstance] = instance.endZone.toString();
		}
		else if (instance.object_index == obj_projectileSpawner) {
			show_debug_message("SAVING PROJECTILE SPAWNER");
			dataList[$ nameInstance] = instance.projectileSpawner.toString();
		}
		else if (instance.object_index = obj_deadZone) {
			show_debug_message("SAVING DEADZONE OBJECT") 
			dataList[$ nameInstance] = instance.deadZone.toString();
		}
	}
}

	
	static saveToJSON = function (fileName) {
		JSONSave(fileName, dataList);
	}
	
	static updateObjectList = function(_objectList) {
		objectList = _objectList;
	}
}