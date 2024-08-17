/// @description Insert description here
// You can write your code in this editor

currentRoom = room_titleScreen;
roomPathStack = new createStack();
global.inputHandler = new createInputHandler([]);

function staggerDefaultInput() {
	if (global.placingInProgress == true) {
		alarm[1] = 5;
	}
	else {
		alarm[0] = 5;
	}
}






















