/// @description Insert description here
// You can write your code in this editor

/// @description Insert description here
// You can write your code in this editor

if (objectData.getIsLevelEditor()) {
	moveAndPlace(objectData);
	levelEditorEvaluateStopFollowing(objectData);
}


if (global.placingInProgress == false && !objectData.isInFocus()) {
	objectData.enterFocus();
}
else {
	objectData.exitFocus();
}

if (objectData.isInFocus()) {
	image_angle = objectData.pointToMouse();
	if (keyboard_check_pressed(vk_space)) {
		if (objectData.getIsLevelEditor()) { // if in testing, then just fire no matter what
			fireProjectile();
		}
		else if (objectData.canProjectileBeFired() != false) { // if in real game and bullets left to shoot, fire
			fireProjectile();
		}
	}
}























