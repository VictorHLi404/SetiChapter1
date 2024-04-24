// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createTextDisplay(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile) constructor {
	
	XCoord = _inputX;
	YCoord = _inputY;
	width = _width;
	height = _height;
	text = _text;
	dataHandler = _dataHandler;
	templateFile = _templateFile;
	
	static getTemplate = function(valueID) {
		return dataHandler.getValue(valueID, templateFile);
	}
	
	color = getTemplate("color");
	font = asset_get_index(getTemplate("font"));
	
	static updateText = function(newText) {
		text = newText;
	}
	
}