text = "QUIT";
buttonID = "QuitButton";
dataHandler = obj_titleScreenDataHandler.dataHandler;
template = "titleScreenButtonTemplate.json";
button = new createButton(x, y, sprite_width, sprite_height, text,  dataHandler, template, buttonID);

function uniqueButtonEvent() {
	game_end();
}