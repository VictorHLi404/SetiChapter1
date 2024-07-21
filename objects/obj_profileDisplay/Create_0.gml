/// @description Insert description here
// You can write your code in this editor

mainProfileDisplay = new createProfileDisplay("MainProfileDisplay", x, y, image_angle, true, global.conversationProfileHandler.getBlankProfile());
displayDataHandler = obj_conversationHubScreenDataHandler.dataHandler;
displayTemplateFile = "bootScreenButtonTemplate.json";
uniqueProfileID = "";

profileNameDisplayField = new createTextDisplay(x+60, y+500, 800, 40, mainProfileDisplay.getName(), displayDataHandler, displayTemplateFile);
profilePositionDisplayField = new createTextDisplay(x+230, y+600, 500, 40, mainProfileDisplay.getPosition(), displayDataHandler, displayTemplateFile);
profileDivisionDisplayField = new createTextDisplay(x+60, y+720, 300, 40, mainProfileDisplay.getDivision(), displayDataHandler, displayTemplateFile);
profileSecurityClearanceDisplayField = new createTextDisplay(x+60, y+770, 300, 40, mainProfileDisplay.getSecurityClearance(), displayDataHandler, displayTemplateFile);
profileEmploymentDateDisplayField = new createTextDisplay(x+60, y+840, 300, 40, mainProfileDisplay.getEmploymentDate(), displayDataHandler, displayTemplateFile);
profileDateOfBirthDisplayField = new createTextDisplay(x+60, y+910, 300, 40, mainProfileDisplay.getDateOfBirth(), displayDataHandler, displayTemplateFile);
profilePersonalTerminalIDDisplayField = new createTextDisplay(x+60, y+990, 300, 40, mainProfileDisplay.getPersonalTerminalID(), displayDataHandler, displayTemplateFile);

openConversationHistoryButton = noone;
openConversationButton = noone;

runningProfileFileName = "";

dataIsLoaded = false;
alarm[0] = 3; 

function createConversationHistoryButtonInstance() {
	var conversationHistoryButtonID = "ConversationHistory" + uniqueProfileID;
	var conversationHistoryButton = new createConversationHistoryButton(x+500, y+710, 410, 150, "HISTORY", displayDataHandler, displayTemplateFile, conversationHistoryButtonID, mainProfileDisplay.getPreviousConversations());
	var conversationHistoryData = mainProfileDisplay.getPreviousConversations();
	openConversationHistoryButton = instance_create_layer(x+500, y+710, "Instances", obj_button);
	
	with (openConversationHistoryButton) {
		button = conversationHistoryButton;
		buttonID = conversationHistoryButtonID;
		previousConversations = conversationHistoryData;
		depth = -10000;
		image_xscale = 6.4;
		image_yscale = 2.34;
		
		uniqueButtonEvent = function() {
			show_message(previousConversations);
		}
	}
	return;
}

function createConversationLoaderButtonInstance() { // ONLY CREATED IF CONVERSATION IS CURRENTLY LOADED
	var conversationLoaderButtonID = "ConversationLoader" + uniqueProfileID;
	var conversationLoaderButton = new createConversationLoaderButton(x+500, y+890, 410, 150, "ANSWER", displayDataHandler, displayTemplateFile, conversationLoaderButtonID, mainProfileDisplay.getCurrentConversationFileName());
	var conversationLoadData = mainProfileDisplay.getCurrentConversationFileName();
	openConversationButton = instance_create_layer(x+500, y+890, "Instances", obj_button);
	
	with (openConversationButton) {
		button = conversationLoaderButton;
		buttonID = conversationLoaderButtonID;
		currentConversationFileName = conversationLoadData;
		depth = -10000;
		image_xscale = 6.4;
		image_yscale = 2.34;
		
		uniqueButtonEvent = function() {
			show_message(currentConversationFileName);
		}
	}
	return;
}

function setToBlank() {
	mainProfileDisplay.setIsBlank(true);
	sprite_index = spr_blankConversationMainDisplay;
	return;
}





















