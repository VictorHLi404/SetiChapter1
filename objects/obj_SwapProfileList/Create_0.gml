/// @description Insert description here
// You can write your code in this editor

startIndex = 0; // index of profile to be displayed at the top
totalNumberOfPages = 1; // total number of elements to be displayed
elementsPerPage = 4; // number of profiles to be displayed per "page"

displayDataHandler = obj_conversationHubScreenDataHandler.dataHandler;
displayTemplateFile = "bootScreenButtonTemplate.json";

moveForwardButtonInstance = noone;
moveBackwardButtonInstance = noone;



function getStartIndex() {
	return startIndex;
}

function getCurrentPageNumber() {
	if (startIndex == 0) {
		return 1;
	}
	else {
		return ceil((startIndex+1)/elementsPerPage);
	}
}

function getTotalNumberOfPages() {
	return totalNumberOfPages;
}

function updateTotalNumberOfPages(stackLength) {
	totalNumberOfPages = ceil(stackLength/elementsPerPage);	
	return;
}

currentPageDisplayField = new createTextDisplay(x+165, y+15, 30, 55, string(getCurrentPageNumber()), displayDataHandler, displayTemplateFile);
totalPagesDisplayField = new createTextDisplay(x+270, y+15, 30, 55, string(totalNumberOfPages), displayDataHandler, displayTemplateFile);


function moveForward() {
	if (startIndex + elementsPerPage < totalNumberOfPages*elementsPerPage) {
		startIndex += elementsPerPage;
		currentPageDisplayField.updateText(getCurrentPageNumber());
	}
	else {
		show_debug_message("GOING FORWARDS OUT OF BOUNDS");
	}
}

function moveBackward() {
	if (startIndex > 1) {
		startIndex -= elementsPerPage;
		currentPageDisplayField.updateText(getCurrentPageNumber());
	}
	else {
		show_debug_message("GOING BACKWARDS OUT OF BOUNDS");
	}
}

function createMoveForwardButtonInstance() {
	var moveForwardButton = new createButton(x+340, y+10, 135, 70, "_", displayDataHandler, displayTemplateFile, "MoveForwardConversationProfileButton");
	moveForwardButtonInstance = instance_create_layer(x+340, y+10, "Instances", obj_button);

	with (moveForwardButtonInstance) {
		depth = -100000;
		image_xscale = 2.10;
		image_yscale = 0.85;
		button = moveForwardButton;
		buttonID = "MoveForwardConversationProfileButton";
	
		uniqueButtonEvent = function() {
			obj_SwapProfileList.moveForward();
			obj_profileDisplay.setToBlank();
		}
	}
}

function createMoveBackwardButtonInstance() {
	var moveBackwardButton = new createButton(x+10, y+10, 135, 70, "_", displayDataHandler, displayTemplateFile, "MoveBackwardConversationProfileButton");
	moveBackwardButtonInstance = instance_create_layer(x+10, y+10, "Instances", obj_button);
	
	with (moveBackwardButtonInstance) {
		depth = -100000;
		image_xscale = 2.10;
		image_yscale = 0.85;
		button = moveBackwardButton;
		buttonID = "MoveBackwardConversationProfileButton";
	
		uniqueButtonEvent = function() {
			obj_SwapProfileList.moveBackward();
			obj_profileDisplay.setToBlank();
		}
	}
}

createMoveForwardButtonInstance();
createMoveBackwardButtonInstance();





















