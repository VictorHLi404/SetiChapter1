// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createQueue() constructor { // array backed modified queue
	internalArray = [];

	static getLength = function() {
		return array_length(internalArray);
	}
	
	static getArray = function() {
		return internalArray;
	}
	
	static append = function(newValue) {
		internalArray[array_length(internalArray)] = newValue;
		return;
	}
	
	static pop = function() {
		var newArray = [];
		for (var i = 1; i < array_length(internalArray); i++) {
			newArray[i-1] = internalArray[i];
		}
		internalArray = newArray;
		return;
	}
	
	static removeIndex = function(index) {
		if (index >= array_length(internalArray)) {
			show_debug_message("REMOVING FROM QUEUE OUT OF BOUNDS")
			return;
		}
		var newArray = [];
		for (var i = 0; i < index; i++) {
			newArray[i] = internalArray[i];
		}
		for (var i = index+1; i < array_length(internalArray); i++) {
			newArray[i-1] = internalArray[i];
		}
		internalArray = newArray;
		return;
	}
	
	static getSubArray = function(startIndex, endIndex) { // end index inclusive
		var subArray = [];
		if (endIndex > array_length(internalArray)-1) {
			endIndex = array_length(internalArray)-1
		}
		for (var i = startIndex; i <= endIndex; i++) {
			subArray[i-startIndex] = internalArray[i];
		}
		return subArray;
	}
	
	static getItem = function(index) {
		return internalArray[index];
	}
}