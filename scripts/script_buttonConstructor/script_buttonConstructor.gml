// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function createButton(_inputX, _inputY, _width, _height, _lineThickness, _color, _text, _font, _buttonID, _roomCursor) constructor 

{
	buttonX = _inputX;
	buttonY = _inputY;
	width = _width;
	height = _height;
	lineThickness = _lineThickness;
	color = _color;
	text = _text;
	font = _font;
	buttonID = _buttonID;
	roomCursor = _roomCursor
	
	
	static leaveFocus = function() {
		global.currentFocus = noone;
	}
	static enterFocusCheck = function() {
		if (position_meeting(mouse_x, mouse_y, buttonID) and (roomCursor.sprite_index == spr_cursor) and global.currentFocus == noone) {
		global.currentFocus = buttonID;
		}
	}
}

