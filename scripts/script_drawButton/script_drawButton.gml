// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function drawButton(buttonData){
	
	with (buttonData) { 
		
		setButtonTextData(font)
		
		x1 = buttonX // leftmost
		y1 = buttonY // topmost
		x2 = buttonX+width; // rightmost
		y2 = buttonY+height; // bottommost

		spacer = floor((floor(width/20)+floor(height/20))/1.5);
	
	if (global.currentFocus == buttonID) {
		
		draw_set_color(c_white);
		draw_set_alpha(1);
		color = c_white;
		
		draw_text(x1+width/2, y1+height/2, text)
		draw_line_width_color(x1+spacer, y1+spacer, x2-spacer, y1+spacer, lineThickness, color, color); // top left to top right
		draw_line_width_color(x1+spacer, y1+spacer, x1+spacer, y2-spacer, lineThickness, color, color); // top left to bottom left
		draw_line_width_color(x1+spacer, y2-spacer, x2-spacer, y2-spacer, lineThickness, color, color); // bottom left to bottom right
		draw_line_width_color(x2-spacer, y1+spacer, x2-spacer, y2-spacer, lineThickness, color, color); // top right to bottom right
		
		}
		
		draw_text(x1+width/2, y1+height/2, text)
		
	draw_line_width_color(x1, y1, x2, y1, lineThickness, color, color); // top left to top right
	draw_line_width_color(x1, y1, x1, y2, lineThickness, color, color); // top left to bottom left
	draw_line_width_color(x1, y2, x2, y2, lineThickness, color, color); // bottom left to bottom right
	draw_line_width_color(x2, y1, x2, y2, lineThickness, color, color); // top right to bottom right
	
	}
	
	
}

function setButtonTextData(font) {
	draw_set_font(font)
	draw_set_color(c_grey)
	draw_set_alpha(0.9)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
}