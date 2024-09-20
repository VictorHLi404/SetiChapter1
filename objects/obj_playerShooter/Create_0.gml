/// @description Insert description here
// You can write your code in this editor


objectData = new createPlayerShooter("PROJECTILE SPAWNER", x, y, image_angle, true, false);
objectArray = [obj_wall, obj_playerWall, obj_deadZone];
projectileSpeed = 5;


function seekWall(currentAngle, xPosition, yPosition) {
	var collisionObject = noone;
	for (var i = 0; i < 100; i++) {
		if (instance_position(xPosition, yPosition, objectArray) != noone) {
			collisionObject = instance_position(xPosition, yPosition, objectArray);
			for (var j = 0; j < 10; j++) { // roll back if overshot
				if (instance_position(xPosition, yPosition, objectArray) == noone) {
					break;
				}
				else {
					xPosition -= lengthdir_x(2, currentAngle); 
					yPosition -= lengthdir_y(2, currentAngle);
				}
			}
			break;
		}
		else { // travel until it hits a wall
			xPosition += lengthdir_x(10, currentAngle); 
			yPosition += lengthdir_y(10, currentAngle);
		}
	}
	return [xPosition, yPosition, collisionObject];
}

function fireProjectile() {
	var projectile = instance_create_layer(x, y, "Instances", obj_projectile);
	var trajectory = image_angle;
	with (projectile) {
		image_angle = trajectory;
		speed = 5;
		direction = trajectory;
	}
}



















