/// @description Insert description here
// You can write your code in this editor

playerResponseKey = new createPlayerResponseKey(0, 0, 0, 0, 0, 0);
submissionButtonInstance = noone;
displayDataHandler = obj_scannerScreenDataHandler.dataHandler;
displayTemplateFile = "bootScreenButtonTemplate.json";
playerAnswers = []; // [distance, upperPitch, lowerPitch, upperGain, lowerGain]

function getPlayerAnswers() {
	return playerAnswers;	
}

function checkAnswer() {
	if (obj_scannerScreenStarmapCursor.getIsPlaced() == true) {
		obj_scannerScreenStarmapCursor.setCanBeMoved(false);
		// isolation variable math, further away from object = fainter main noise, higher bar = more dependent on location
		var currentXY = obj_scannerScreenStarmapCursor.getDataObject().getXY();
		var mapXY = obj_starmapOverlay.getDataObject().getFramePosition(global.timeKeeper.getCurrentTime());
		// combine with current position within total map from 
		var isolationAdjustmentValue = 1;
		var upperGainValue = global.INT_MAX;
		var lowerGainValue = global.INT_MAX;
		for (var i = 0; i < instance_number(obj_sliderButton); i++) {
			var tempSliderObject = variable_instance_get(instance_find(obj_sliderButton,i),"sliderButton");
			if (tempSliderObject.getType() == "IsolationSlider") {
				isolationAdjustmentValue = tempSliderObject.getValueRelativeToMax();
			}
			else if (tempSliderObject.getType() == "LowerGainSlider") {
				lowerGainValue = tempSliderObject.getValueRelativeToMax();
			}
			else if (tempSliderObject.getType() == "UpperGainSlider") {
				upperGainValue = tempSliderObject.getValueRelativeToMax();
			}
		}
		var gainValues = playerResponseKey.calculateGain(currentXY[0]+mapXY[0], currentXY[1]+mapXY[1], isolationAdjustmentValue, upperGainValue, lowerGainValue);

		var upperPitchWideValue = global.INT_MAX;
		var upperPitchFineValue = global.INT_MAX;
		var lowerPitchWideValue = global.INT_MAX;
		var lowerPitchFineValue = global.INT_MAX;
		for (var i = 0; i < instance_number(obj_knob); i++) {
			var tempKnobObject = variable_instance_get(instance_find(obj_knob,i),"knob");
			if (tempKnobObject.getType() == "UpperPitchWideAdjustment") { // OPTIMIZE HOLY SHIT
				upperPitchWideValue = tempKnobObject.getValue();
			}
			else if (tempKnobObject.getType() == "UpperPitchFineAdjustment") {
				upperPitchFineValue = tempKnobObject.getValue();
			}
			else if (tempKnobObject.getType() == "LowerPitchWideAdjustment") {
				lowerPitchWideValue = tempKnobObject.getValue();
			}
			else if (tempKnobObject.getType() == "LowerPitchFineAdjustment") {
				lowerPitchFineValue = tempKnobObject.getValue();
			}
		}
		var pitchValues = playerResponseKey.calculatePitch(upperPitchWideValue, upperPitchFineValue, lowerPitchWideValue, lowerPitchFineValue);
		playerAnswers[0] = playerResponseKey.getDistanceFromPoint(currentXY[0]+mapXY[0], currentXY[1]+mapXY[1]);
		playerAnswers[1] = playerResponseKey.getPitchInterval(upperPitchWideValue, upperPitchFineValue);
		playerAnswers[2] = playerResponseKey.getPitchInterval(lowerPitchWideValue, lowerPitchFineValue);
		playerAnswers[3] = upperGainValue;
		playerAnswers[4] = lowerGainValue;
		show_message(gainValues);
		show_message(pitchValues);
		obj_playerResponsePlayer.updatePlayerValues(gainValues, pitchValues);
		obj_scannerScreenStarmapCursor.alarm[0] = obj_answerPlayer.getTrackLength();
	}
}

function updateAnswerKey(answerData) {
	show_message(answerData);
	playerResponseKey.updateAnswerKey(answerData);
	instance_destroy(submissionButtonInstance);
	submissionButtonInstance = noone;
	createSubmissionButtonInstance();
}

function createSubmissionButtonInstance() {
	var newButtonID = "SignalSubmissionButtonInstance";
	var newButton = new createButton(1240, 10, 190, 70, "PROCESS", displayDataHandler, displayTemplateFile, newButtonID);
	submissionButtonInstance = instance_create_layer(1240, 10, "Instances", obj_button);
	with (submissionButtonInstance) {
		buttonID = newButtonID;
		button = newButton;
		depth = -10000;
		image_xscale = 2.97;
		image_yscale = 1.10;
		uniqueButtonEvent = function() {
			obj_playerResponseKey.checkAnswer();
			var currentSignalID = obj_signalSelector.getCurrentSignalID();
			var currentPlayerResponseKey = obj_playerResponseKey.getPlayerAnswers();
			show_message("SHOWING DATA FOR SIGNAL " + currentSignalID);
			show_message(currentPlayerResponseKey);
			global.signalHandler.submitSignal(currentSignalID, currentPlayerResponseKey);
			instance_destroy(self);
		}
	}	
}




















