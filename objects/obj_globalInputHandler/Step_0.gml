/// @description Insert description here
// You can write your code in this editor

if (keyboard_check_pressed(vk_escape)) {
	if (room != room_titleScreen) {
		roomPathStack.pop();
		room_goto(roomPathStack.peek());
	}
}























