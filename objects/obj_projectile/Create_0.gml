/// @description Insert description here
// You can write your code in this editor

projectileData = new createProjectile(self, 5);
objectArray = [obj_wall, obj_playerWall, obj_deadZone, obj_endZone];
collisionBuffer = false;

function startCollisionBuffer() {
	collisionBuffer = true;
	alarm[0] = 10;
}



