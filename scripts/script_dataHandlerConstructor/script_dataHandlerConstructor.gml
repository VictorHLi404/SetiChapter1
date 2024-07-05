// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createDataHandler(_fileList) constructor { // PLEASE GO OVER THIS HSIT AND NOTATE IT PROPERLY
	fileList = _fileList;
	fileData = {};
	fileNames = [0];
	
	static addFiles = function(fileList) {	// function to store the raw JSON data inside of struct fileData
		for (var i = 0; i < array_length(fileList); i++) {
			var JSONData = JSONRead(fileList[i]);
			fileData[$ fileList[i]] = JSONData;
			fileNames[i] = fileList[i];
 		}
		return;
	}
	
	addFiles(fileList); // default initialization for data struct, runs when created
	
	
	static saveFiles = function() { // saves all of the files back into json format
		for (var i = 0; i < array_length(fileNames); i++) {
			JSONSave(fileNames[i], fileData[$ fileNames[i]]);
		}
		return; 
	}
	
	static getStructValue = function(valueID, _currentStruct) { // "private" method used to recursively search for a value within a json file given a name and a decomplied JSON
		var currentStruct = _currentStruct;
		var structLength = struct_names_count(currentStruct);
		var structNames = struct_get_names(currentStruct);
		
		for (var i = 0; i < structLength; i++) {
			if (typeof(currentStruct[$ structNames[i]]) == "struct") {
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
	
	static getStructRecursive = function(structName, _currentStruct) { // 'private' method used to recursively search for entire struct within json file given name and decompiled json
		var currentStruct = _currentStruct;
		var structLength = struct_names_count(currentStruct);
		var structNames = struct_get_names(currentStruct);
		
		for (var i = 0; i < structLength; i++) {
			if (typeof(currentStruct[$ structNames[i]]) == "struct") {
				if (structNames[i] == structName) {
					return currentStruct[$ structNames[i]];
				}
				else {
					var internalStruct = getStructRecursive(structName, currentStruct[$ structNames[i]]); // make sure that it loops through all options
					if (internalStruct != noone) {
						return internalStruct;
					}
				}
			}
		}
		return noone;
	}	
	
	static getFile = function(fileName) { // wrapper function to get the JSON struct from a json string name
		return fileData[$ fileName];
	}
	
	static getValue =  function(valueID, fileName) { // "public" method used to get the desired value, but name of the struct must be given
		return getStructValue(valueID, getFile(fileName));
	}
	
	static getStruct = function(structName, fileName) {
		return getStructRecursive(structName, getFile(fileName));
	}
		
	static updateStructValue = function(newValue, valueID, _currentStruct) { // "private" method used to recursively search for the name of the value to replace and then replaces it within struct
		
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
	
	static updateValue = function(newValue, valueID, fileName) { // "public" method to use, giving value, name of variable, and then file name to update within
		updateStructValue(newValue, valueID, getFile(fileName));
		
	}
}
