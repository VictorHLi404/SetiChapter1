// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createRoomScanner(_objectList) constructor {
	//
	objectList = _objectList;
	dataList = {};	
	
	static saveCurrentRoom = function() {
	for (var i = 0; i < array_length(objectList); i++) {
		var instance = objectList[i];
		if (instance.object_index == obj_wall) {
			var nameInstance = object_get_name(instance.object_index) + " " + string(i);
			dataList[$ nameInstance] = instance.wallData.toString();
			}
		}
	}

	
	static saveToJSON = function (fileName) {
		JSONSave(fileName, dataList);
	}
}