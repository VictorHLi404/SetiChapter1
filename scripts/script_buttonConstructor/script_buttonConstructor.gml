// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function createButton(_inputX, _inputY, _width, _height, _text, _buttonID, _dataHandler, _templateFile) constructor 

{
	buttonX = _inputX;
	buttonY = _inputY;
	width = _width;
	height = _height;
	text = _text;
	buttonID = _buttonID;
	dataHandler = _dataHandler;
	templateFile = _templateFile;
	
	static getTemplate = function(valueID) {
		return dataHandler.getValue(valueID, templateFile);
	
	}	

	lineThickness = getTemplate("lineThickness");
	color = getTemplate("color");
	font = asset_get_index(getTemplate("font"));
	roomCursor = asset_get_index(getTemplate("roomCursor"));
	
	
	
	static leaveFocus = function() {
		global.currentFocus = noone;
	}
	
	static enterFocusCheck = function() {
		if (position_meeting(mouse_x, mouse_y, buttonID) and (roomCursor.sprite_index == spr_cursor) and global.currentFocus == noone) {
		global.currentFocus = buttonID;
		}
	}
	
	static buttonPressed = function() {
		if (global.action and global.currentFocus = buttonID) { 
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
	
	
}

