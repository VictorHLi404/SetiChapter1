/// @description Insert description here
// You can write your code in this editor

cellDataDisplay = new createCellDisplay("CellDisplay", x, y, image_angle, true, global.loadManagerHandler.getBlankCell());
// takes in processingcell as argument, NOT subroutine
displayDataHandler = obj_loadManagementScreenDataHandler.dataHandler;
displayTemplateFile = "bootScreenButtonTemplate.json";
uniqueProfileID = "";

cellNameDisplayField = new createTextDisplay(x+75, y+40, 175, 15, cellDataDisplay.getName(), displayDataHandler, displayTemplateFile)
cellDescriptionDisplayField = new createTextDisplay(x+70, y+90, 190, 15, cellDataDisplay.getDescription(), displayDataHandler, displayTemplateFile);

runningCellID = "";

dataIsLoaded = false;
alarm[0] = 2;

modifyButtonInstance = noone;

function updateCellDataDisplay(newCellData) { // take in PROCESSING CELL, not subprocess
	cellDataDisplay.updateCellData(newCellData);
	cellNameDisplayField.updateText(cellDataDisplay.getName());
	cellDescriptionDisplayField.updateText(cellDataDisplay.getDescription());
}

function resetCellDataDisplay() {
	updateCellDataDisplay(global.loadManagerHandler.getBlankCell());
}


function createDeleteButtonInstance() {
	var cellData = cellDataDisplay.getCellData();
	var _cellID = cellData.getType();
	var deleteButtonID = "DeleteButton" + _cellID;
	var deleteButton = new createModifyCellDataButton(x+10, y+110, 300, 40, "DELETE", displayDataHandler, displayTemplateFile, deleteButtonID, _cellID);
	modifyButtonInstance = instance_create_layer(x+10, y+110, "Instances", obj_button);
	
	with (modifyButtonInstance) {
		button = deleteButton;
		buttonID = deleteButtonID;
		cellID = _cellID; 
		depth = -1000;
		image_xscale = 4.68;
		image_yscale = 0.625;
		uniqueButtonEvent = function() {
			global.loadManagerHandler.deleteFromNetwork(cellID);
			obj_cellDataDisplay.resetCellDataDisplay();
		}
	}
}

function createRepairButtonInstance() {
	var cellData = cellDataDisplay.getCellData();
	var _cellID = cellData.getType();
	var repairButtonID = "RepairButton" + _cellID;
	var repairButton = new createModifyCellDataButton(x+10, y+110, 300, 40, "REPAIR", displayDataHandler, displayTemplateFile, repairButtonID, _cellID);
	modifyButtonInstance = instance_create_layer(x+10, y+110, "Instances", obj_button);
	
	with (modifyButtonInstance) {
		button = repairButton;
		buttonID = repairButtonID;
		cellID = _cellID; 
		depth = -1000;
		image_xscale = 4.68;
		image_yscale = 0.625;
		uniqueButtonEvent = function() {
			global.loadManagerHandler.beginFixingNode(cellID);
		};
	}
	
}
















