text = "OPTIONS";
buttonID = "OptionsButton";
dataHandler = obj_titleScreenDataHandler.dataHandler;
template = "titleScreenButtonTemplate.json";
button = new createButton(x, y, sprite_width, sprite_height, text,  dataHandler, template, buttonID);

function uniqueButtonEvent() {
	show_message("NEW NEW SHIT");
	return;
}