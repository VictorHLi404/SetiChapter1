// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createPlayerResponseKey(_answerX, _answerY, _upperPitchAnswer, _lowerPitchAnswer, _upperGainAnswer, _lowerGainAnswer) constructor {
	
	answerX = _answerX;
	answerY = _answerY; 
	minimumDistance = 300; // minimum distance needed for any kind of dampening effect to start
	upperPitchAnswer = _upperPitchAnswer;
	lowerPitchAnswer = _lowerPitchAnswer;
	upperGainAnswer = _upperGainAnswer;
	lowerGainAnswer = _lowerGainAnswer;
	
	static isolationDistanceToFloat = function(distance) {
		var isolationFloat = sqrt(distance/minimumDistance);
		if (isolationFloat > 1) {
			return 1;
		}
		else {
			return isolationFloat;
		}
	}
	
	static normalizeIsolation = function(volumeFloat, isolationFactor) {
		floatDistance = abs(0.5-volumeFloat)/isolationFactor;
		if (volumeFloat < 0.5) {
			return 0.5-floatDistance;
		}
		else {
			return 0.5+floatDistance;
		}
	}
	
	static calculateIsolation = function(cursorX, cursorY, isolationFactor) { // takes in position of starmap cursor, returns array containing numbers between 1-100 that represent gain values for respective objects
		// [answerVolume, noiseVolume]
		distanceFromPoint = floor(getPythagoreanDistance(answerX, answerY, cursorX, cursorY));
		show_message(distanceFromPoint);
		if (distanceFromPoint > minimumDistance) { // fucked up, go find another one
			return [generateRandomFloat(0.1, 0.3), generateRandomFloat(0.7, 0.9)]
		}
		else {
			var remainingDistance = minimumDistance - distanceFromPoint;
			var isolationFloat = isolationDistanceToFloat(remainingDistance);
			var answerVolume = isolationFloat;
			var noiseVolume = 1 - isolationFloat;
			return [normalizeIsolation(answerVolume, isolationFactor), normalizeIsolation(noiseVolume, isolationFactor)];
		}
	}
	
	static calculateGain = function(cursorX, cursorY, isolationFactor, upperGain, lowerGain) {
		//[upperGainValue, lowerGainValue, noiseGainValue]
		isolationValues = calculateIsolation(cursorX, cursorY, isolationFactor);
		gainValues = [isolationValues[0]+gainIntervalToFloat(upperGain-upperGainAnswer), isolationValues[0]+gainIntervalToFloat(lowerGain-lowerGainAnswer), isolationValues[1]];
		if (gainValues[0] < 0) { ///ooooooooooooooooooooooooooptimize
			gainValues[0] = 0;
		}
		if (gainValues[1] < 0) {
			gainValues[1] = 0;
		}
		if (gainValues[0] > 1) {
			gainValues[0] = 1;
		}
		if (gainValues[1] > 1) {
			gainValues[1] = 1;
		}
		return gainValues;
	}
	
	static getPitchInterval = function(wideAdjustment, fineAdjustment) {
		return wideAdjustment + (1/10)*fineAdjustment;
	}
	
	static pitchIntervalToFloat = function(interval) {
		var pitchAdjustment = 1+((1/2000)*power(interval,3));
		if (pitchAdjustment < 0.05) {
			pitchAdjustment = 0.05;	
		}
		else if (pitchAdjustment > 2) {
			return 2;
		}
		return pitchAdjustment;
	}
	
	static calculatePitch = function(upperPitchWideInterval, upperPitchFineInterval, lowerPitchWideInterval, lowerPitchFineInterval) {
		//[upperPitchAdjusted, lowerPitchAdjusted]
		var upperPitchInterval = getPitchInterval(upperPitchWideInterval, upperPitchFineInterval);
		var lowerPitchInterval = getPitchInterval(lowerPitchWideInterval, lowerPitchFineInterval);
		return [pitchIntervalToFloat(upperPitchInterval-upperPitchAnswer), pitchIntervalToFloat(lowerPitchInterval-lowerPitchAnswer)];
	}
	
	static gainIntervalToFloat = function(interval) {
		return (1/100)*(-1*power((interval-1),2));
	}
}