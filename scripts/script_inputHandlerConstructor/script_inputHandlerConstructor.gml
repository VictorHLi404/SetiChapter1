// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createInputHandler(_buttonList) constructor 

{
	window_set_cursor(cr_none);
	buttonList = _buttonList
	global.currentFocus = noone;
	global.left = false;
	global.right = false;
	global.up = false;
	global.down = false;
	global.action = false;
	
	static checkKeyboardPress = function() {
		global.left = false;
		global.right = false;
		global.up = false;
		global.down = false;

		if (keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"))) {
			global.down = true;
		}
		else if (keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"))) {
			global.up = true;
		}
		else if (keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"))) {
			global.right = true;
		}
		else if (keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"))) {
			global.left = true;
		}
	
	}
	
	static keyboardPressed = function() {
		if (global.left or global.right or global.up or global.down) {
			if (global.currentFocus == noone) {
				global.currentFocus = buttonList[0];
				return;
			}
			else {
				var currentPressed;
		
				if (global.left) { currentPressed = global.left;}
				if (global.right) { currentPressed = global.right;}
				if (global.down) { currentPressed = global.down;}
				if (global.up) { currentPressed = global.up;}
		
				checkButtonDirection(currentPressed);
			}
		}	
	}
	
	static checkButtonDirection = function(currentPressed) {
		currentX = global.currentFocus.x;
		currentY = global.currentFocus.y;
		for (var i = 1; i < floor(room_width/20); i++) {
			switch(currentPressed) {
				case global.left:
					currentX -= 20;
				break;
				case global.right:
					currentX += 20;
				break;
				case global.up:
					currentY -= 20;
				break;
				case global.down:
					currentY += 20;
				break;
			}
		
			if (currentX > room_width) {currentX = currentX-room_width;}
			if (currentX < 0) {currentX = currentX+room_width;}
			if (currentY > room_height) {currentY = currentY-room_width;}
			if (currentY < 0) {currentY = currentY+room_width;}
		
			for (var j = 0; j < array_length(buttonList); j++) {
				if (buttonList[j] == global.currentFocus) {
					continue;
				}
				if (position_meeting(currentX, currentY, buttonList[j])) {
					global.currentFocus = buttonList[j];
					return;
				}
			}
		}
	}
	
	static checkAction = function() {
		if (mouse_check_button_pressed(mb_left) or keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space)) {
			global.action = true;
			show_debug_message("action")
		}
	}
	

}