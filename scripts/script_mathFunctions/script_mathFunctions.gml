// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function getPythagoreanDistance(x1, y1, x2, y2) {
	return sqrt(power(abs(x1-x2),2)+(power(abs(y1-y2),2)));
}

function generateRandomFloat(lowerBound, upperBound) {
	return random_range(lowerBound, upperBound);
}