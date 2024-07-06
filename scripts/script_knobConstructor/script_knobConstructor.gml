// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createKnob(_type, _x, _y, _imageAngle, _active, _defaultInternalValue, _maxValue, _defaultAngle, _angleTolerance) : createAdjustableRoomObject(_type, _x, _y, _imageAngle, _active, _defaultInternalValue, _maxValue) constructor {
	
	defaultAngle = _defaultAngle;
	angleTolerance = _angleTolerance;
	angleRange = angleTolerance*maxValue;
	maxLeftAngle = defaultAngle + angleRange;
	maxRightAngle = defaultAngle - angleRange;
	
	static pointToMouse = function() { // returns angle for projectile spanwer to point IF in focus
		if (active) {
			return point_direction(xPosition, yPosition, mouse_x, mouse_y);
		}
		else {
			return global.INT_MIN;
		}
	}
	static moveKnob = function(currentAngle) {
		var newValue = floor((defaultAngle-currentAngle)/angleTolerance);
		updateInternalValue(newValue);
		updateImageAngle(currentAngle);
	}
	
	static angleCorrection = function(currentAngle) { // convert from 360 overshoot when turning right into negative number
		if (currentAngle >= maxLeftAngle+angleTolerance && currentAngle <= 360) {
			return currentAngle-360;
		}
		else {
			return currentAngle;
		}
	}

	static getDefaultAngle = function() {
		return defaultAngle;
	}	
	static getAngleRange = function() {
		return angleRange;
	}
	static getAngleTolerance = function() {
		return angleTolerance;
	}
	static getMaxLeftAngle = function() {
		return maxLeftAngle;
	}
	static getMaxRightAngle = function() {
		return maxRightAngle;
	}
	
}