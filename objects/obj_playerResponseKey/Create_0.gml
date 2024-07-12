/// @description Insert description here
// You can write your code in this editor

playerResponseKey = new createPlayerResponseKey(720, 360, 6, -7, 2, -3);

function checkAnswer() {
	if (obj_scannerScreenStarmapCursor.getIsPlaced() == true) {
		obj_scannerScreenStarmapCursor.setCanBeMoved(false);
		// isolation variable math, further away from object = fainter main noise, higher bar = more dependent on location
		var currentXY = obj_scannerScreenStarmapCursor.getDataObject().getXY();
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
		var gainValues = playerResponseKey.calculateGain(currentXY[0], currentXY[1], isolationAdjustmentValue, upperGainValue, lowerGainValue);
		
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
		
		show_message(gainValues);
		show_message(pitchValues);
		
		obj_playerResponsePlayer.playResponseSound(gainValues, pitchValues);
		obj_scannerScreenStarmapCursor.alarm[0] = obj_answerPlayer.getTrackLength();
	}
}




















