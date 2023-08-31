// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createDataHandler(fileList) constructor {
	
	fileData = {};
	fileNames = [0];
	
	static addFiles = function(fileList) {	
		for (var i = 0; i < array_length(fileList); i++) {
			var JSONData = JSONRead(fileList[i]);
			fileData[$ fileList[i]] = JSONData;
			fileNames[i] = fileList[i];
 		}
		return;
	}
	
	addFiles(fileList);
	
	show_debug_message(fileData);
	
	static saveFiles = function() {
		for (var i = 0; i < array_length(fileNames); i++) {
			JSONSave(fileNames[i], fileData[$ fileNames[i]]);
		}
		return;
	}
	
	static internalGetValue = function(valueID, _currentStruct) {
		
		var currentStruct = _currentStruct;
		var structLength = struct_names_count(currentStruct);
		var structNames = struct_get_names(currentStruct);
		
		for (var i = 0; i < structLength; i++) {
			if typeof(currentStruct[$ structNames[i]]) == "struct" {
				var searchStruct = currentStruct[$ structNames[i]];
				//currentStruct = currentStruct[$ structNames[i]];
				if (internalGetValue(valueID, searchStruct) != noone) {
					return internalGetValue(valueID, searchStruct);
				}
			}
			else if (structNames[i] == valueID) {
				return currentStruct[$ structNames[i]];
			}
		}
		return noone;
	}
	
	static getFile = function(fileName) {
		return fileData[$ fileName];
	}
	
	static getValue =  function(valueID, fileName) {
		return internalGetValue(valueID, getFile(fileName));
	}
		
	static internalUpdateValue = function(newValue, valueID, _currentStruct) {
		
		var currentStruct = _currentStruct;
		var structLength = struct_names_count(currentStruct);
		var structNames = struct_get_names(currentStruct);
		
		for (var i = 0; i < structLength; i++) {
			if typeof(currentStruct[$ structNames[i]]) == "struct" {
				var searchStruct = currentStruct[$ structNames[i]];
				//currentStruct = currentStruct[$ structNames[i]];
				internalUpdateValue(newValue, valueID, searchStruct);
			}
			else if (structNames[i] == valueID) {
				currentStruct[$ structNames[i]] = newValue;
			}
		}
		return;
	}
	
	static updateValue = function(newValue, valueID, fileName) {
		internalUpdateValue(newValue, valueID, getFile(fileName));
		show_debug_message(fileData);
		return;
	}
}
