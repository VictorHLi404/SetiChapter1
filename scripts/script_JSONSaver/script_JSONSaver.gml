// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function script_JSONSaver(JSONString, targetFile) {
	/*show_debug_message("SAVING FILE")
	show_debug_message(JSONString)
	show_debug_message(targetFile)*/
	var writeBuffer = buffer_create(string_byte_length(JSONString)+1, buffer_fixed, 2);
	buffer_write(writeBuffer, buffer_string, JSONString)
	buffer_save(writeBuffer, JSONString)
	show_debug_message("WRITING BUFFER")
	show_debug_message(writeBuffer)
	buffer_delete(writeBuffer);

}