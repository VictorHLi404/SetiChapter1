// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/* UNIVERSAL JSON SCRIPT HANDLER = USE FOR MENUS, SAVE DATA, ETC

takes JSON file as a parameter and then searches for if it exists, returns error code if it does not

returns JSON file as a struct / nested array to work through

*/
function script_JSONReader(targetFile){
	
	if file_exists(targetFile) {
		show_debug_message(targetFile + "file does exist");
		
		var file = file_text_open_read(targetFile);
		
		var JSONdata = "";
		while(file_text_eof(file) == false) {
			JSONdata  += file_text_readln(file)
		}
		
		file_text_close(file)
		
		var parsedData = json_parse(JSONdata)
		return parsedData;
		
	}
	
	else {
		show_debug_message(targetFile + "does not exist");
		return;
	}

}