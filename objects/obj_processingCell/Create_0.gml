/// @description Insert description here
// You can write your code in this editor

cellData = global.loadManagerHandler.getBlankCell();
currentSubprocessType = "";
pickupX = 0;
pickupY = 0;


function updateCellSprite() {
	var subprocessType = (cellData.getCurrentSubprocess()).getSubprocessType();
	if (subprocessType == "Corrupted") {
		sprite_index = spr_corruptedNode;
	}
	else if (subprocessType == "InProgress") {
		sprite_index = spr_inProgressNode;
	}
	else if (subprocessType == "Data") {
		sprite_index = spr_dataCell;
	}
	else {
		sprite_index = spr_coreProcessingUnit;
	}
}














