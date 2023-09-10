// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createDataHandler(_fileList) constructor {
	fileList = _fileList
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
	
	
	static saveFiles = function() {
		for (var i = 0; i < array_length(fileNames); i++) {
			JSONSave(fileNames[i], fileData[$ fileNames[i]]);
		}
		return;
	}
	
	static getStructValue = function(valueID, _currentStruct) {
		
		var currentStruct = _currentStruct;
		var structLength = struct_names_count(currentStruct);
		var structNames = struct_get_names(currentStruct);
		
		for (var i = 0; i < structLength; i++) {
			if typeof(currentStruct[$ structNames[i]]) == "struct" {
				var searchStruct = currentStruct[$ structNames[i]];
				if (getStructValue(valueID, searchStruct) != noone) {
					return getStructValue(valueID, searchStruct);
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
		return getStructValue(valueID, getFile(fileName));
	}
		
	static updateStructValue = function(newValue, valueID, _currentStruct) {
		
		var currentStruct = _currentStruct;
		var structLength = struct_names_count(currentStruct);
		var structNames = struct_get_names(currentStruct);
		
		for (var i = 0; i < structLength; i++) {
			if typeof(currentStruct[$ structNames[i]]) == "struct" {
				var searchStruct = currentStruct[$ structNames[i]];
				//currentStruct = currentStruct[$ structNames[i]];
				updateStructValue(newValue, valueID, searchStruct);
			}
			else if (structNames[i] == valueID) {
				currentStruct[$ structNames[i]] = newValue;
			}
		}
		return;
	}
	
	static updateValue = function(newValue, valueID, fileName) {
		updateStructValue(newValue, valueID, getFile(fileName));
		
	}
}
