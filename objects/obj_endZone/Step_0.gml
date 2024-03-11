/// @description
// You can write your code in this editor



if (place_meeting(x, y, obj_projectile)) { // surely a better way to do this....
	var projectile = instance_place(x, y, obj_projectile);
	instance_destroy(projectile);
	endZone.setWin(true);
}







