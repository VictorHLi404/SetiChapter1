/// @description Insert description here
// You can write your code in this editor

puzzleObjectSpawner = new createPuzzleObjectSpawner("BLANK", true, 5);

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

























