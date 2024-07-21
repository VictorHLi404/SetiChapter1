/// @description Insert description here
// You can write your code in this editor


profileIcon.checkIsBlank();

if (dataIsLoaded) {
	if (profileIcon.getFileName() != runningProfileFileName) {
		instance_destroy(openMainProfileButtonInstance);
		openMainProfileButtonInstance = noone;
		
		if (!profileIcon.getIsBlank()) {
			profileNameDisplayField.updateText(profileIcon.getName());
			profilePositionDisplayField.updateText(profileIcon.getPosition());
			createMainProfileButtonInstance();	
		}
		runningProfileFileName = profileIcon.getFileName();
	}
}




















