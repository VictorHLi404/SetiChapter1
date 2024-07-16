/// @description Insert description here
// You can write your code in this editor

if (taskDisplay.getIsBlank()) {
	sprite_index = spr_blankTask;
	draw_self();
}
else {
	sprite_index = spr_taskObject;
	draw_self();
	drawTextBox(taskNameDisplayField);
	drawTextBox(taskDescriptionDisplayField);
	draw_rectangle(x+1000, y+25, x+1000+(completionRatio*completionBarLength), y+25+completionBarHeight, 0);
}
























