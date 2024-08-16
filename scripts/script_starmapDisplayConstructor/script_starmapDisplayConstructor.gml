// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createStarmapDisplay(_type, _x, _y, _imageAngle, _active, _viewWidth, _viewHeight) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor {
	viewWidth = _viewWidth;
	viewHeight = _viewHeight;
	defaultXPosition = 5700-(viewWidth/2);
	defaultYPosition = 1240-(viewHeight/2);
	defaultRightAscension = 4;
	oppositeXPosition = 1810;
	oppositeYPosition = 720;
	
	static getViewWidth = function() {
		return viewWidth;
	}
	
	static getViewHeight = function() {
		return viewHeight;
	}
	
	static getVerticalOffset = function(currentDay) { // same sine function, different vertical offset
		return -ceil(200*sin(((2*pi*currentDay))/365 - (365*pi/2)) + 200);
	}
	static getHorizontalOffset = function(currentDay) { // different "starting" position of the loop"
		return -ceil(1900*sin(((2*pi*currentDay))/365 - (365*pi/2)) + 1900);
	}
	
	static getYPositionOnSineCurve = function(currentXPosition) {
		return -675*sin(pi*currentXPosition/7200)+1600;
	}
	
	static convertRightAscensionToXPosition = function(currentRightAscension) {
		return (-7200/24) * currentRightAscension + 7200;
	}	
	
	static convertHourToRightAscension = function(currentHour) {
		var rightAscension = currentHour+defaultRightAscension;
		if (rightAscension > 24) {
			rightAscension -= 24;
		}
		return rightAscension;
	}
	
	static getFramePosition = function(currentTime) {
		var currentHour = currentTime %  24;
		var currentDay = floor(currentTime/24);
		var xCoord = floor(convertRightAscensionToXPosition(convertHourToRightAscension(currentHour))+getHorizontalOffset(currentDay));
		if (xCoord < 0) {
			xCoord = 7200+xCoord;
		}
		else if (xCoord > 7200) {
			xCoord = xCoord-7200;
		}
		var yCoord = floor(getYPositionOnSineCurve(xCoord) + getVerticalOffset(currentDay));
		return getTopLeftCoordFromCenter(xCoord, yCoord);
	}
	
	static getTopLeftCoordFromCenter = function(xCoord, yCoord) {
		return [xCoord-(viewWidth/2), yCoord-(viewHeight/2)];
	}
}