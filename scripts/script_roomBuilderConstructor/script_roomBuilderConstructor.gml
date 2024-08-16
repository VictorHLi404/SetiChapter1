// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createRoomBuilder(_fileNames) constructor {
	// CURRENT ROOM DATA; ROOM THAT IS CURRENTLY BEING MODIFIED / ON DISPLAY
	// ROOMDATA: DATA TO PULL FOR ALL ITERATIONS
	fileNames = _fileNames;
	
	static loadCurrentRoom = function() {
		var sourceFile = "currentRoomData.json";
		var dataStruct = JSONRead(sourceFile);
		var structNames = struct_get_names(dataStruct);
		for (var i = 0; i < array_length(structNames); i++) {
			var instanceData = dataStruct[$ structNames[i]];
			
			if (instanceData[0] == "WALL") {
				instance_create_layer(instanceData[1], instanceData[2], "Instances", obj_wall, {
					image_angle : instanceData[3]
				});
			}
			else if (instanceData[0] == "PM_WALL") {
				instance_create_layer(instanceData[1], instanceData[2], "Instances", obj_wall, {
					image_angle : instanceData[3],
					sprite_index : spr_playerCreatedWall
				});
			}
			else if (instanceData[0] == "ENDZONE") {
				instance_create_layer(instanceData[1], instanceData[2], "ZoneLayer", obj_endZone);
			}
			
			else if (instanceData[0] == "DEADZONE") {
				instance_create_layer(instanceData[1], instanceData[2], "ZoneLayer", obj_deadZone);
			}
			else if (instanceData[0] == "PROJECTILE SPAWNER") {
				var inst = instance_create_layer(instanceData[1], instanceData[2], "Instances", obj_playerShooter);
				with (inst) {
					projectileSpawner.setProjectileCount(floor(instanceData[5]));
				}
			}
		}	
	}

}