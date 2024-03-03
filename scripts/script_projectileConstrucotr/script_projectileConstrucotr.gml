// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createProjectile(_id, _bounceCount) constructor {
	
	objectID = _id;
	bounceCount = _bounceCount;
	
	static checkWallCollision = function() { // called by projectile object when it collides with a WALL, checks if it can bounce any more times
		if (bounceCount > 0) {
			bounceCount--;
			return true;
		}
		else {
			return false;
		}
	}

}