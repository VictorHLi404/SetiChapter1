// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function drawButton(buttonData){
	
	with (buttonData) { 
		
		setButtonTextData(font)
		
		x1 = buttonX
		y1 = buttonY
		x2 = buttonX+width;
		y2 = buttonY+height;
	
	draw_line_width_color(x1, y1, x2, y1, lineThickness, color, color);
	draw_line_width_color(x1, y1, x1, y2, lineThickness, color, color);
	draw_line_width_color(x1, y2, x2, y2, lineThickness, color, color);
	draw_line_width_color(x2, y1, x2, y2, lineThickness, color, color);
	
	draw_text(x1+width/2, y1+height/2, text)
	}
	
	
}

function setButtonTextData(font) {
	draw_set_font(font)
	draw_set_color(c_white)
	draw_set_alpha(0.9)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
}