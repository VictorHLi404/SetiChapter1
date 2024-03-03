// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createprojectileSpawner(_inputX, _inputY, _projectileCount) constructor {
	
	XCoord = _inputX;
	YCoord = _inputY;
	projectileCount = _projectileCount;
	inFocus = true;

static pointToMouse = function() { // returns angle for projectile spanwer to point IF in focus
	if (inFocus) {
		return point_direction(XCoord, YCoord, mouse_x, mouse_y);
	}
	else {
		return noone;
	}
}

static enterFocus = function() { 
	inFocus = true;
}

static exitFocus = function() {
	inFocus = false;
}

static isInFocus = function() {
	return inFocus;
}

static fireProjectile = function() {
	if (projectileCount > 0) {
		projectileCount -= 1;
		return true;
	}
	else {
		return false;
	}
}
}