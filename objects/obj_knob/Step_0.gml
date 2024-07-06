/// @description Insert description here
// You can write your code in this editor

if(mouse_check_button(mb_left) && position_meeting(mouse_x, mouse_y, self)) {
	knob.enterFocus();
	show_debug_message("IN FOCUS")
}

if (knob.isInFocus()) {
	if (mouse_check_button_released(mb_left) || !position_meeting(mouse_x, mouse_y, self)) { // pay attention to hitbox of knob if not working properly
		knob.exitFocus();
	}
}

if (knob.isInFocus()) {
	var newDirection = knob.pointToMouse();
	if (knob.getMaxRightAngle() <= newDirection && newDirection <= knob.getMaxLeftAngle()) { // movement within bounds
		if (abs(knob.getDefaultAngle()-image_angle) <= knob.getAngleRange()) {
			if (image_angle-newDirection >= knob.getAngleTolerance()) { // turning right
				image_angle -= knob.getAngleTolerance();
				knob.moveKnob(image_angle);
			}
			else if (newDirection-image_angle >= knob.getAngleTolerance()) { // turning left
				image_angle += knob.getAngleTolerance();
				knob.moveKnob(image_angle);
			}
		}
	}
	else if (knob.getMaxRightAngle()-knob.getAngleTolerance() <= knob.angleCorrection(newDirection) && knob.angleCorrection(newDirection) <= knob.getMaxRightAngle()) { // right overshoot accounting
		image_angle = 0;
		knob.moveKnob(image_angle);
	}
	else if (knob.getMaxLeftAngle() <= newDirection && newDirection <= knob.getMaxLeftAngle()+knob.getAngleTolerance()) { // left overshoot accounting
		image_angle = knob.getMaxLeftAngle();
		knob.moveKnob(image_angle);
	}
}
















