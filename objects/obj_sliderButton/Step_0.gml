/// @description Insert description here
// You can write your code in this editor

if(mouse_check_button(mb_left) && position_meeting(mouse_x, mouse_y, self)) {
	sliderButton.enterFocus();
}

if (sliderButton.isInFocus()) {
	if (mouse_check_button_released(mb_left) || !position_meeting(mouse_x, mouse_y, self)) { // pay attention to hitbox of knob if not working properly
		sliderButton.exitFocus();
	}
}

if (sliderButton.isInFocus()) {
	var mousePosition;
	if (sliderButton.sliderIsHorizontal()) {
		mousePosition = mouse_x;
	}
	else {
		mousePosition = mouse_y;
	}
	if (sliderButton.isCoordinateWithinRange(mousePosition)) {
		if (mousePosition-sliderButton.getPosition() > sliderButton.getMovementTolerance()) { // "increase"
			sliderButton.increasePosition();
			x = sliderButton.getX();
			y = sliderButton.getY();
		}
		else if (sliderButton.getPosition()-mousePosition > sliderButton.getMovementTolerance()) { // 'decrease'
			sliderButton.decreasePosition();
			x = sliderButton.getX();
			y = sliderButton.getY();
		}
	}
}

















