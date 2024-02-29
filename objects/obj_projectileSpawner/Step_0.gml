/// @description Insert description here
// You can write your code in this editor


image_angle = projectileSpawner.pointToMouse();

if (keyboard_check_pressed(vk_space) && projectileSpawner.isInFocus()) {
	if (projectileSpawner.fireProjectile() != false) {
		var projectile = instance_create_layer(x, y, "Instances", obj_projectile);
		var trajectory = image_angle;
		with (projectile) {
			image_angle = trajectory;
			speed = 10;
			direction = trajectory;
		}
		show_debug_message(trajectory);
	}
}
//image_angle = point_direction(x, y, mouse_x, mouse_y);







