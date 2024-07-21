/// @description Insert description here
// You can write your code in this editor


profileIcon = new createProfileDisplay("ProfileIcon", x, y, image_angle, true, global.conversationProfileHandler.getBlankProfile());
displayDataHandler = obj_conversationHubScreenDataHandler.dataHandler;
displayTemplateFile = "bootScreenButtonTemplate.json";
uniqueProfileID = "";

profileNameDisplayField = new createTextDisplay(x+170, y+35, 300, 40, profileIcon.getName(), displayDataHandler, displayTemplateFile);
profilePositionDisplayField = new createTextDisplay(x+170, y+110, 300, 40, profileIcon.getPosition(), displayDataHandler, displayTemplateFile);

openMainProfileButtonInstance = noone;

runningProfileFileName = "";

dataIsLoaded = false;
alarm[0] = 3;


function createMainProfileButtonInstance() {
	var openMainButtonID = "OpenMain"+uniqueProfileID;
	var openMainButton = new createProfileButton(x, y, 480, 180, "_", displayDataHandler, displayTemplateFile, openMainButtonID, profileIcon);
	var openMainButtonData = profileIcon;
	openMainProfileButtonInstance = instance_create_layer(x, y, "Instances", obj_button);
	
	with (openMainProfileButtonInstance) {
		button = openMainButton;
		buttonID = openMainButtonID;
		profileData = openMainButtonData;
		depth = -10000;
		image_xscale = 7.5;
		image_yscale = 2.8;
		
		uniqueButtonEvent = function() {
			var tempMainProfile = variable_instance_get(instance_find(obj_profileDisplay, 0),"mainProfileDisplay");
			tempMainProfile.updateProfileData(profileData.getProfileData());
		}
	}
}

function updateUniqueProfileID(index) {
	uniqueProfileID = "ConversationIcon"+string(index);
}















