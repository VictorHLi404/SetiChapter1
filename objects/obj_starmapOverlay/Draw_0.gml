/// @description Insert description here
// You can write your code in this editor
draw_self();
var xCoord = currentPositionData[0];
var yCoord = currentPositionData[1];
var width = starmapDisplay.getViewWidth();
var height = starmapDisplay.getViewHeight();
draw_sprite_part(spr_starmapGuide, 0, xCoord, yCoord, width, height, x, y);

if (xCoord < 0) { // overshot to the right
	//show_debug_message("OVERSHOT TO LEFT")
	draw_sprite_part(spr_starmapGuide, 0, 7200+xCoord, yCoord, xCoord*-1, height, x, y);
}
else if (xCoord > 7200-width) {
	//show_debug_message("OVERSHOT TO RIGHT");
	draw_sprite_part(spr_starmapGuide, 0, 0, yCoord, xCoord-(7200-width), height, x+width-(xCoord-(7200-width)), y);
}




















