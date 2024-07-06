// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createSliderButton(_type, _x, _y, _imageAngle, _active, _defaultInternalValue, _maxValue, _movementTolerance, _sliderBackground, _isHorizontal) : createAdjustableRoomObject(_type, _x, _y, _imageAngle, _active, _defaultInternalValue, _maxValue) constructor{
	
	defaultX = getX();
	defaultY = getY();
	movementTolerance = _movementTolerance;
	sliderBackground = _sliderBackground;
	isHorizontal = _isHorizontal;
	distanceRange = maxValue*movementTolerance;
	
	if (isHorizontal) {
		maxDecreaseDistance = xPosition-distanceRange;
		maxIncreaseDistance = xPosition+distanceRange;
	}
	else {
		maxDecreaseDistance = yPosition-distanceRange;
		maxIncreaseDistance = yPosition+distanceRange;
	}
	
	// default x y position defined by center point of slider bar
		// contains object reference to the slider bar
	// change movement depending on if its a horizontal or vertical bar
	
	static moveButton = function(currentPosition) {
		if (isHorizontal) {
			var newValue = floor((currentPosition-defaultX)/movementTolerance) // 0 - max goes from left to right
			updateInternalValue(newValue);
			show_debug_message(internalValue);
			updateXY(currentPosition, getY());
		}
		else {
			var newValue = floor((defaultY-currentPosition)/movementTolerance); // 0 to max goes from top to bottom
			updateInternalValue(newValue);
			show_debug_message(internalValue);
			updateXY(getX(), currentPosition);
		}
	}
	
	static isCoordinateWithinRange = function(coordinate) { // checks if thing is within range
		return (coordinate <= maxIncreaseDistance+movementTolerance && coordinate >= maxDecreaseDistance-movementTolerance);
	}
	
	static increasePosition = function() {
		if (isHorizontal) {
			xPosition += movementTolerance;
			updateInternalValue(floor(xPosition-defaultX)/movementTolerance);
		}
		else {
			yPosition += movementTolerance;
			updateInternalValue(floor(defaultY-yPosition)/movementTolerance);
		}
	}
	
	static decreasePosition = function() {
		if (isHorizontal) {
			xPosition -= movementTolerance;
			updateInternalValue(floor(xPosition-defaultX)/movementTolerance);
		}
		else {
			yPosition -= movementTolerance;
			updateInternalValue(floor(defaultY-yPosition)/movementTolerance);
		}
	}
	
	static getPosition = function() { // returns assumed relavent position depending on isHorizontal
		if (isHorizontal) {
			return getX();
		}
		else {
			return getY();
		}
	}
	
	static getDefaultPosition = function() { // returns assumed default depending on given from isHorizontal 
		if (isHorizontal) {
			return defaultX;
		}
		else {
			return defaultY;
		}
	
	}	
	static getMaxDecreaseDistance = function() {
		return maxDecreaseDistance;
	}
	static getMaxIncreaseDistance = function() {
		return maxIncreaseDistance;
	}	
	static getMovementTolerance = function() {
		return movementTolerance;
	}
	static sliderIsHorizontal = function() {
		return isHorizontal;
	}
}