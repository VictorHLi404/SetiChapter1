/// @description Insert description here
// You can write your code in this editor

displayDataHandler = obj_scannerScreenDataHandler.dataHandler;
displayTemplateFile = "bootScreenButtonTemplate.json";

currentSignalDisplayField = new createTextDisplay(x+10, y+20, 630, 60, "NO SIGNAL CURRENTLY SELECTED", displayDataHandler, displayTemplateFile);
signalSelector = new createSignalSelector(global.signalHandler.getActiveSignalList());
forwardButtonInstance = noone;
backwardButtonInstance = noone;

function getCurrentSignal() {
	return signalSelector.getCurrentSignal();
}

function getCurrentSignalName() {
	return signalSelector.getCurrentSignalName();
}

function getCurrentSignalID() {
	return signalSelector.getCurrentSignalID();
}


function nextSignal() {
	if (!signalSelector.isEmpty()) {
		signalSelector.forwardPosition();
		currentSignalDisplayField.updateText(signalSelector.getCurrentSignalName());
		obj_playerResponseKey.updateAnswerKey(signalSelector.getCurrentSignalAnswerData());
		obj_playerResponsePlayer.updateAudioData(signalSelector.getCurrentSignalAudioData());
		obj_answerPlayer.updateAudioData(signalSelector.getCurrentSignalAudioData());
	}
}

function previousSignal() {
	if (!signalSelector.isEmpty()) {
		signalSelector.backwardPosition();
		currentSignalDisplayField.updateText(signalSelector.getCurrentSignalName());
		obj_playerResponseKey.updateAnswerKey(signalSelector.getCurrentSignalAnswerData());
		obj_playerResponsePlayer.updateAudioData(signalSelector.getCurrentSignalAudioData());
		obj_answerPlayer.updateAudioData(signalSelector.getCurrentSignalAudioData());
	}
}

function createForwardButton() {
	var newButtonID = "signalSelectorForwardButton";
	var newButton = new createButton(x+650, y+50, 35, 35, "_", displayDataHandler, displayTemplateFile, newButtonID);
	forwardButtonInstance = instance_create_layer(x+650, y+50, "Instances", obj_button);
	with (forwardButtonInstance) {
		depth = -10000;
		image_xscale = 0.55;
		image_yscale = 0.55;
		button = newButton;
		buttonID = newButtonID;
		uniqueButtonEvent = function() {
			obj_signalSelector.nextSignal();
		}
	}
}

function createBackwardButton() {
	var newButtonID = "signalSelectorBackwardButton";
	var newButton = new createButton(x+650, y+10, 35, 35, "_", displayDataHandler, displayTemplateFile, newButtonID);
	backwardButtonInstance = instance_create_layer(x+650, y+10, "Instances", obj_button);
	with (backwardButtonInstance) {
		depth = -10000;
		image_xscale = 0.55;
		image_yscale = 0.55;
		button = newButton;
		buttonID = newButtonID;
		uniqueButtonEvent = function() {
			obj_signalSelector.previousSignal();
		}
		
	}
}

createForwardButton();
createBackwardButton();





















