// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createCellDisplay(_type, _x, _y, _imageAngle, _active, _cellData) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor {
	cellData = _cellData;
	
	static isBlank = function() {
		return cellData.isBlank();
	}
	
	static getName = function() {
		return cellData.getName();
	}
	
	static getDescription = function() {
		return cellData.getDescription();
	}
	
	static getCellData = function() {
		return cellData;
	}
	
	static updateCellData = function(newCellData) {
		cellData = newCellData;
	}
	
	static getSubprocessData = function() {
		return cellData.getCurrentSubprocess();	
	}
	
	static getCellDataID = function() {
		return cellData.getType();
	}
}

function createModifyCellDataButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID, _cellID) : createButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID) constructor {
	cellID = _cellID;
}