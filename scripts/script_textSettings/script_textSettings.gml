// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function setDefaultText(font){
	draw_set_font(font);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
}

function setDefaultTextBox(font) {
	draw_set_color(c_white);
	draw_set_alpha(1);
	setDefaultText(font);
}

function setButtonTextData(font) {
	draw_set_color(c_grey);
	draw_set_alpha(0.9);
	setDefaultText(font);
}
