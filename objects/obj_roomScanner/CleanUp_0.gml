/// @description Insert description here
// You can write your code in this editor
var instances= [instance_number(all)];

for (var i = 0; i < instance_number(all); i++) {
	var instance = instance_find(all, i);
	instances[i] = instance;
}
roomScanner.updateObjectList(instances);
roomScanner.saveCurrentRoom();
roomScanner.saveToJSON("currentRoomData.json");
show_debug_message("CURRENT ROOM BUILD SAVED!");












