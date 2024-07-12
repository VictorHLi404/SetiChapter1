/// @description Insert description here
// You can write your code in this editor
var tempSliderBar = instance_place(x, y, obj_sliderBackground).sliderBackground;
var isHorizontal;
if (tempSliderBar.getImageAngle() == 0) {
	isHorizontal = true;
}
else {
	isHorizontal = false;
}
x = tempSliderBar.getX(); // zero the bar to start in the middle
y = tempSliderBar.getY();

sliderButton = new createSliderButton("SliderButton", x, y, image_angle, false, 0, 10, 10, tempSliderBar, isHorizontal);






















