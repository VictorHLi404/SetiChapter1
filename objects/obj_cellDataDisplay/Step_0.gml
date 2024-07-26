/// @description Insert description here
// You can write your code in this editor

if (dataIsLoaded) {
	if (cellDataDisplay.getCellDataID() != runningCellID) {
		instance_destroy(modifyButtonInstance);
		modifyButtonInstance = noone;
		var subprocessType = cellDataDisplay.getCellData().getCurrentSubprocess().getSubprocessType();
		if (subprocessType == "Data") {
			createDeleteButtonInstance();
		}
		else if (subprocessType == "Corrupted") {
			createRepairButtonInstance();
		}
		runningCellID = cellDataDisplay.getCellDataID();
	}
}
























