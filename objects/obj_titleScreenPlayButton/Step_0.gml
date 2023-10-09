/// @description Insert description here
// You can write your code in this editor

event_inherited();

if (button.buttonPressed()) {
	var playedIntro = button.getData("playedIntro", "introStatus.json");
	
	if (playedIntro == true) {
		room_goto(room_bootConversationScreen);
	}
	else {
		button.updateData(true, "playedIntro", "introStatus.json");
	}
}












