/// @description Insert description here
// You can write your code in this editor


// draw two bounce line based off of walls, reflects off of them, draw until wall is hit


draw_self();

var firstBounceXY = seekWall(image_angle, x, y);
var firstCollisionInstance = firstBounceXY[2];
var firstCollisionAngle = calculateBounceAngle(image_angle, firstBounceXY[0], firstBounceXY[1], firstCollisionInstance.x, firstCollisionInstance.y);
var secondBounceXY = seekWall(firstCollisionAngle, firstBounceXY[0], firstBounceXY[1]);
show_debug_message([image_angle, firstCollisionAngle]);
draw_line(x+lengthdir_x(13, image_angle), y+lengthdir_y(13, image_angle), firstBounceXY[0], firstBounceXY[1]);
draw_line(firstBounceXY[0], firstBounceXY[1], secondBounceXY[0], secondBounceXY[1]);


























