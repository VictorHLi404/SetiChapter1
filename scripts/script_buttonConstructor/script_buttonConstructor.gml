// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function createButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID) : createTextDisplay(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile) constructor {	
	
	buttonID = _buttonID;
	lineThickness = getTemplate("lineThickness");
	roomCursor = asset_get_index(getTemplate("roomCursor"));
	
	static leaveFocus = function() {
		global.currentFocus = noone;
	}
	
	static enterFocusCheck = function() {
		if ((variable_instance_get(instance_position(mouse_x, mouse_y, obj_button), "buttonID") == buttonID)) {
			if ( global.currentFocus == noone) {
					global.currentFocus = buttonID;
			}
		}
	}
	
	static enterConversationFocusCheck = function() {
		if ((variable_instance_get(instance_position(mouse_x, mouse_y, obj_conversationButton), "buttonID") == buttonID) and (roomCursor.sprite_index == spr_cursor) and global.currentFocus == noone) {
			global.currentFocus = buttonID;
		}
	}
	
	static buttonPressed = function() {
		if (global.action and global.currentFocus == buttonID) { 
			return true;
		}
		else { return false; }
	}
	
	static updateData = function(newValue, valueID, fileName) {
		dataHandler.updateValue(newValue, valueID, fileName);
	}
	
	static getData = function(valueID, fileName) {
		return dataHandler.getValue(valueID, fileName);
	}
	
	static setToNoCollision = function() {
		sprite_index = spr_noCollision;
	}
	
	static setToCollision = function() {
		sprite_index = spr_blank;
	}
	
}

function createStateButton (_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID, _initialState) : createButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID) constructor { // true or false button
	
	internalState = _initialState;
	
	static setInternalState = function(state) {
		internalState = state;
	}
	
	static getInternalState = function(state) {
		return internalState;
	}
}

