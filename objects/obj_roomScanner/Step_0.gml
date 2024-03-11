/// @description Insert description here
// You can write your code in this editor


if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, self)) {
	roomScanner.saveCurrentRoom();
	roomScanner.saveToJSON("currentRoomData.json");
	show_debug_message("CURRENT ROOM BUILD SAVED!");
}







