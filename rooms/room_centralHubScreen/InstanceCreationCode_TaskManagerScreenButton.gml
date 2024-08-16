text = "TASKS";
buttonID = "TaskManagerScreenButton";
dataHandler = obj_centralHubDataHandler.dataHandler;
template = "centralHubScreenButtonTemplate.json";

button = new createButton(x, y, sprite_width, sprite_height, text,  dataHandler, template, buttonID);

sprite_index = spr_endzone;
function uniqueButtonEvent() {
	room_goto(room_taskManagerScreen);
}