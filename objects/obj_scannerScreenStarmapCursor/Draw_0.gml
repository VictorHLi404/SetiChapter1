/// @description Insert description here
// You can write your code in this editor
// draw self and aiming lines like a crosshair

draw_self();
draw_line(x-edgeDistance, y, 0, y);
draw_line(x+edgeDistance, y, widthBox, y);
draw_line(x, y-edgeDistance, x, 0);
draw_line(x, y+edgeDistance, x, heightBox);





















