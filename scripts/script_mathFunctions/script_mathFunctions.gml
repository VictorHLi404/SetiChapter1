// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function getPythagoreanDistance(x1, y1, x2, y2) {
	return sqrt(power(abs(x1-x2),2)+(power(abs(y1-y2),2)));
}

function generateRandomFloat(lowerBound, upperBound) {
	return random_range(lowerBound, upperBound);
}

function mirrorAngleAlongYAxis(angle) {
	if (angle <= 180) {
		return 180-angle;
	}
	else {
		return 540-angle;
	}
}

function calculateBounceAngle(currentAngle, xPosition, yPosition, collisionInstanceX, collisionInstanceY) {
	var xDirection = collisionInstanceX - xPosition;
	var yDirection = collisionInstanceY - yPosition;
	var newAngle = 0;
	if (abs(yDirection) > abs(xDirection)) { // if the bullet is coming from either on top or below
		if ((yDirection < 0 && currentAngle < 180 && currentAngle > 0)) {
			newAngle = mirrorAngleAlongYAxis((currentAngle+180)%360);
			show_debug_message("BELOW HIT");
		}
		else if (yDirection > 0 && currentAngle <= 360 && currentAngle >= 180) {
			newAngle = mirrorAngleAlongYAxis((currentAngle+180)%360);
			show_debug_message("TOP HIT");
		}
		// +180 to flip side, then mirror across y axis
	}
	else if (abs(xDirection) > abs(yDirection)) { // if bullet is coming from left or right
			newAngle = (mirrorAngleAlongYAxis(currentAngle));
			show_debug_message("SIDE HIT");
	}
	else {
		show_debug_message("CORNER CASE");
	}
	if (random_range(1, 2) > 1.5) {
		newAngle = (newAngle+5)%360;
	}
	else {
		newAngle = (newAngle-5)%360;
	}
	return newAngle;
}

function mirrorAngleAlongXAxis(angle) {

}