// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function setGlobals(){
	global.left = false;
	global.right = false;
	global.up = false;
	global.down = false;
	
	global.action = false; // boolean that dictates whethere an input has taken place on the current frame
	global.currentFocus = noone; // variable that contains the current button / menu thing highlighted
	
	global.placingInProgress = false; // variable for the battle room to see if itme 
	global.timeKeeper = {}; // variable that stores the global tick counter that events listen to n shit
	
	global.INT_MIN = -2000000; // variables for placeholder "out of reach" values
	global.INT_MAX = 2000000;
}