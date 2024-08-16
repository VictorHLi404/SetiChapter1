/// @description Insert description here
// You can write your code in this editor

if (objectData.getIsLevelEditor()) {
	moveAndPlace(objectData);
	levelEditorEvaluateStopFollowing(objectData);
}


if (global.placingInProgress == false) {
	objectData.enterFocus();
}

else {
	objectData.exitFocus();
}

if (objectData.isInFocus()) {
	image_angle = objectData.pointToMouse();
	if (keyboard_check_pressed(vk_space)) {
		if (objectData.fireProjectile() != false) {
			var projectile = instance_create_layer(x, y, "Instances", obj_projectile);
			var trajectory = image_angle;
			with (projectile) {
				image_angle = trajectory;
				speed = 5;
				direction = trajectory;
			}
		}
	}
}