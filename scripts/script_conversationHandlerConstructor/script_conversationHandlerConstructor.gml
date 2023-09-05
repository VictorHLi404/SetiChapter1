// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationHandler(_fileList) : createDataHandler(_fileList) constructor {
	
	//conversationData = {}; struct to store all raw data
	//fileNames = []; list of all file names
	
	fileList = _fileList
	addFiles(fileList);
	
	currentGraph = {}; //
	global.currentMessage = {}
	realMessageStruct = {};
	fakeMessageStruct = {};
	currentSelect = noone;
	leftRealMessage = noone;
	leftFakeMessage = noone;
	midRealMessage = noone;
	midFakeMessage = noone;
	rightRealMessage = noone;
	rightFakeMessage = noone;
	
	static loadConversation = function(_fileName) {
		
		var fileName = _fileName;
		var rawData = getFile(fileName)//[$ "Packages"][$ "Models"];
		rawData = rawData[$ "Packages"][0][$ "Models"]; // break down into main core
		
		for (var i = 0; i < array_length(rawData); i++) {
			
			var currentStruct = rawData[i]
				
			if (currentStruct.Type == "DialogueFragment") { // if its a node in the conversation graph
					
				var currentID = currentStruct[$ "Properties"][$ "Id"]; // add to graph
				var outputPins = currentStruct[$ "Properties"][$ "OutputPins"][0];
				var currentIDOptions = [];
				
				for (var j = 0; j < array_length(outputPins[$ "Connections"]); j++) {
					array_push(currentIDOptions, outputPins[$ "Connections"][j][$ "Target"]);
				}
				struct_set(currentGraph, currentID, currentIDOptions);
				/*show_debug_message("PARENT NODE")
				show_debug_message(currentID)
				show_debug_message("CHILD NODES")
				show_debug_message(global.currentGraph[$ currentID])*/
			}
		}
		show_debug_message(currentGraph);
		return;
	}
	
	loadConversation(fileNames[0]);
}