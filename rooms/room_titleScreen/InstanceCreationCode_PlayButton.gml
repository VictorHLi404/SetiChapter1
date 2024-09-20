text = "PLAY";
buttonID = "PlayButton";
dataHandler = obj_titleScreenDataHandler.dataHandler;
template = "titleScreenButtonTemplate.json";
button = new createButton(x, y, sprite_width, sprite_height, text,  dataHandler, template, buttonID);

function uniqueButtonEvent() {
	var playedIntro = button.getData("playedIntro", "introStatus.json");
	
	if (playedIntro == true) {
		room_goto(room_centralHubScreen);
	}
	else {
		button.updateData(true, "playedIntro", "introStatus.json");
	}
	return;
}