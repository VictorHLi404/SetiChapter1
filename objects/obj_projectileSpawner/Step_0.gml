/// @description Insert description here
// You can write your code in this editor


if (mouse_check_button_pressed(mb_left)) {
	if (position_meeting(mouse_x, mouse_y, self)) {
		projectileSpawner.enterFocus();
	}
	else {
		projectileSpawner.exitFocus();
	}
	
}



if (projectileSpawner.isInFocus()) {
	image_angle = projectileSpawner.pointToMouse();
	if (keyboard_check_pressed(vk_space)) {
		if (projectileSpawner.fireProjectile() != false) {
			var projectile = instance_create_layer(x, y, "Instances", obj_projectile);
			var trajectory = image_angle;
			with (projectile) {
				image_angle = trajectory;
				speed = 10;
				direction = trajectory;
			}
		}
	}
}