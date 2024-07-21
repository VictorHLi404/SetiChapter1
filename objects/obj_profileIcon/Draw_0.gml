/// @description Insert description here
// You can write your code in this editor

if (dataIsLoaded) {
	if (profileIcon.getIsBlank()) {
		sprite_index = spr_blankConversationIcon;
	}
	else {
		sprite_index = spr_conversationIcon;
		draw_self();
		drawTextBox(profileNameDisplayField);
		drawTextBox(profilePositionDisplayField);
	}
}























