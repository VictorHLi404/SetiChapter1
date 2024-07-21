/// @description Insert description here
// You can write your code in this editor

mainProfileDisplay.checkIsBlank();

if (dataIsLoaded) {
	if (mainProfileDisplay.getFileName() != runningProfileFileName) { // if change in update
		instance_destroy(openConversationHistoryButton);
		instance_destroy(openConversationButton);
		openConversationHistoryButton = noone;
		openConversationButton = noone;

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
				createConversationLoaderButtonInstance();
			}
		}
		runningProfileFileName = mainProfileDisplay.getFileName();
	}
}





















