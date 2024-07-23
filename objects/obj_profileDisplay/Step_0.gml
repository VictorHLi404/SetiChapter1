/// @description Insert description here
// You can write your code in this editor

mainProfileDisplay.checkIsBlank();

if (dataIsLoaded) {
	if (mainProfileDisplay.getFileName() != runningProfileFileName) { // if change in profile
		instance_destroy(openConversationHistoryButton);
		instance_destroy(openConversationButton);
		openConversationHistoryButton = noone;
		openConversationButton = noone;
		hasCurrentConversation = false;

		if (!mainProfileDisplay.getIsBlank()) {
			profileNameDisplayField.updateText(mainProfileDisplay.getName());
			profilePositionDisplayField.updateText(mainProfileDisplay.getPosition());
			profileDivisionDisplayField.updateText(mainProfileDisplay.getDivision());
			profileSecurityClearanceDisplayField.updateText(mainProfileDisplay.getSecurityClearance());
			profileEmploymentDateDisplayField.updateText(mainProfileDisplay.getEmploymentDate());
			profileDateOfBirthDisplayField.updateText(mainProfileDisplay.getDateOfBirth());
			profilePersonalTerminalIDDisplayField.updateText(mainProfileDisplay.getPersonalTerminalID());
			createConversationHistoryButtonInstance();
			if (mainProfileDisplay.getHasCurrentConversation()) {
				hasCurrentConversation = true;
				createConversationLoaderButtonInstance();
			}
		}
		runningProfileFileName = mainProfileDisplay.getFileName();
	}
	if (hasCurrentConversation != mainProfileDisplay.getHasCurrentConversation()) { // if change in conversastion
			if (mainProfileDisplay.getHasCurrentConversation()) { // if button is to be made
				hasCurrentConversation = true;
				createConversationLoaderButtonInstance();
			}
			else { // if button is to be destroyed
				instance_destroy(openConversationButton);
				openConversationButton = noone;
				hasCurrentConversation = false;
			}
	}
}





















