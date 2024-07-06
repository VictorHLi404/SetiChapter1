// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createAdjustableRoomObject(_type, _x, _y, _imageAngle, _active, _defaultInternalValue, _maxValue) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor {

	internalValue = _defaultInternalValue; // integer that contains the current set value of the object
	maxValue = _maxValue; // max range on either negative or positive side, assume to be +/-
	
	static updateInternalValue = function(newValue) {
		if (-9 <= newValue && newValue <= maxValue) {
			internalValue = newValue;
			show_debug_message(internalValue);
		}
	}
	// consider moving towards main function
	static enterFocus = function() { 
		active = true;
	}

	static exitFocus = function() {
		active = false;
	}

	static isInFocus = function() {
		return active;
	}

}