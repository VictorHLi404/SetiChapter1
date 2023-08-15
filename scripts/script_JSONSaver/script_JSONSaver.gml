// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
/* 
UNIVERSAL JSON SCRIPT HANDLER = USE FOR MENU, SAVE DATA, etc

takes struct as a parameter, converts it to a json string, and then writes it to local data with buffer

returns nothing



*/
function script_JSONSaver(JSONFile, targetFile) {
	var JSONString = json_stringify(JSONFile, true)
	var writeBuffer = buffer_create(string_byte_length(JSONString)+1, buffer_fixed, 1);
	buffer_write(writeBuffer, buffer_string, JSONString)
	buffer_save(writeBuffer, targetFile)
	buffer_delete(writeBuffer);
	return;
}