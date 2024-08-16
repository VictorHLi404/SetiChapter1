/// @description Insert description here
// You can write your code in this editor

starmapDisplay = new createStarmapDisplay("ScannerStarmapDisplay", x, y, image_angle, true, 1430, 650);
currentPositionData = starmapDisplay.getFramePosition(global.timeKeeper.getCurrentTime());

function getDataObject() {
	return starmapDisplay;
}



















