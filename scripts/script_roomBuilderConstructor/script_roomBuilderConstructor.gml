// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createRoomBuilder(_fileNames) constructor {
	// CURRENT ROOM DATA; ROOM THAT IS CURRENTLY BEING MODIFIED / ON DISPLAY
	// ROOMDATA: DATA TO PULL FOR ALL ITERATIONS
	fileNames = _fileNames;
	
	static loadCurrentRoom = function() {
		var sourceFile = "currentRoomData.json";
		var dataStruct = JSONRead(sourceFile);
		show_debug_message(dataStruct);
		var structNames = struct_get_names(dataStruct);
		show_debug_message(structNames);
		for (var i = 0; i < array_length(structNames); i++) {
			var instanceData = dataStruct[$ structNames[i]];
			show_debug_message(instanceData);
			if (instanceData[0] == "WALL") {
				instance_create_layer(instanceData[1], instanceData[2], "Instances", obj_wall, {
					image_angle : instanceData[3]
				})
			}
		}	
	}

}