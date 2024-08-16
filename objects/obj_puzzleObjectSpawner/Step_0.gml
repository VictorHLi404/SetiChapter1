/// @description Insert description here
// You can write your code in this editor



if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, self)) {
	if (puzzleObjectSpawner.canObjectSpawn() == true) {
		global.placingInProgress = true;
		var levelEditorBool = puzzleObjectSpawner.getIsLevelEditor();
		var objectInstance = instance_create_layer(mouse_x, mouse_y, "Instances", puzzleObjectSpawner.getObject());
		with (objectInstance) {
			objectData.setFollowingMouse(true);
			objectData.updateIsLevelEditor(levelEditorBool);
		}
	}
}























