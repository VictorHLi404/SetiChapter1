/// @description Insert description here
// You can write your code in this editor

puzzleObjectSpawner = new createPuzzleObjectSpawner("BLANK", false, 5);
remainingObjectDisplayField = new createTextDisplay(x+49, y+49, 19, 19, "", global.displayHandler, "bootScreenButtonTemplate.json");
remainingObjectDisplayField.updateText(puzzleObjectSpawner.getObjectCurrentCount());
function loadSpawnerSprite() {
	sprite_index = puzzleObjectSpawner.getSprite();
	return;
}

function updateSpawnerType(newType) {
	puzzleObjectSpawner.updateType(newType);
	loadSpawnerSprite();
	return;
}

function updateIsLevelEditor(boolean) {
	puzzleObjectSpawner.updateIsLevelEditor(boolean);
}


loadSpawnerSprite();

if (room == room_levelEditorScreen) {
	puzzleObjectSpawner.updateIsLevelEditor(true);	
}
























