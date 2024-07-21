/// @description Insert description here
// You can write your code in this editor


if (dataIsLoaded) {
	if (mainProfileDisplay.getIsBlank()) {
		sprite_index = spr_blankConversationMainDisplay;
	}
	else {
		sprite_index = spr_conversationMainDisplay;
		draw_self();
		drawTextBox(profileNameDisplayField);
		drawTextBox(profilePositionDisplayField);
		drawTextBox(profileDivisionDisplayField);
		drawTextBox(profileDateOfBirthDisplayField);
		drawTextBox(profileEmploymentDateDisplayField);
		drawTextBox(profileSecurityClearanceDisplayField);
		drawTextBox(profilePersonalTerminalIDDisplayField);
	}
}






















