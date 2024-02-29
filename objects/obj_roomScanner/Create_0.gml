/// @description Insert description here
// You can write your code in this editor

var instances = {};

for (var i = 0; i < instance_number(obj_wall); i++) {
	var instance = instance_find(obj_wall, i);
	instances[i] = instance;
	show_debug_message(instance.x);
}




