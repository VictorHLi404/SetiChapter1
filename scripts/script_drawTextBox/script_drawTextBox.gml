// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function drawTextBox(textBoxData) {
	// calculate how many "lines" are required from length of string and given width
	// find center x and y of textbox
	// split up lines according to height n location
	with (textBoxData) {

		setDefaultTextBox(font);
		
		x1 = XCoord // leftmost
		y1 = YCoord // topmost
		x2 = XCoord+width; // rightmost
		y2 = YCoord+height; // bottommost
		if (text != noone) {
			draw_text(x1+width/2, y1+height/2, text);
		}
		else {
			draw_rectangle(x1,y1,x2,y2, false);
		}
	}
}

function drawAlternateTextBox(textBoxData) { // inverted, blue instead of white
	with (textBoxData) {
		
		x1 = XCoord // leftmost
		y1 = YCoord // topmost
		x2 = XCoord+width; // rightmost
		y2 = YCoord+height; // bottommost
		if (text != noone) {
			draw_text_color(x1+width/2, y1+height/2, text, c_blue, c_blue, c_blue, c_blue, 1);
		}
		else {
			draw_rectangle(x1,y1,x2,y2, false);
		}
	}
}