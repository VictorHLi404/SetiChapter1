// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createPlayerShooter(_type, _x, _y, _imageAngle, _active, _isLevelEditor) : createPuzzleObject(_type, _x, _y, _imageAngle, _active, _isLevelEditor) constructor { 

	static pointToMouse = function() { // returns angle for projectile spanwer to point IF in focus
		if (active) {
			return point_direction(xPosition, yPosition, mouse_x, mouse_y);
		}
		else {
			return noone;
		}
	}

	static enterFocus = function() { 
		active = true;
	}

	static exitFocus = function() {
		active = false;
	}

	static isInFocus = function() {
		return active;
	}

	static canProjectileBeFired = function() {
		if (global.puzzleHandler.isAttemptValid()) {
			global.puzzleHandler.recordPuzzleAttempt();
			return true;
		}
		else {
			return false;
		}
	}

	static toString = function() {
		return [type, xPosition, yPosition, imageAngle, active, projectileCount];
		}
}