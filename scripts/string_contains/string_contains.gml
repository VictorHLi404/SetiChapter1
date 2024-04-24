// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function string_contains(substr, str) { // check if the substring is inside of the string
	if (string_count(substr, str) > 0) {
		return true;
	}
	else {
		return false;
	}
}