/// @description Insert description here
// You can write your code in this editor

global.left = false;
global.right = false;
global.up = false;
global.down = false;


switch (keyboard_key) {
	case vk_left:
	case ord("A"):
		global.left = true;
	break;
	
	case vk_right:
	case ord("D"):
		global.right = true;
	break;
	
	case vk_up:
	case ord("W"):
		global.up = true;
	break;
	
	case vk_down:
	case ord("S"):
		global.down = true;
	break;
}















