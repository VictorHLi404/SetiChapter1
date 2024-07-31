// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createSignalData(_signalID, _name, _minimumTimeElapsed, _isActive, _audioData, _solutionData, _uponCompletionTasks) constructor {
	signalID = _signalID; // string
	name = _name; // string
	minimumTimeElapsed = _minimumTimeElapsed; // int to determine how many ticks before it becomes available to the player
	hasBeenReleased = _isActive; // boolean to determine whether to display it in the drop down menu
	audioData = _audioData; // struct, contains [upperAudioFile, lowerAudiofile, noiseFile]
	solutionData = _solutionData; // struct, contains [location, uGain, LGain, uPitch, lPitch] 
	uponCompletionTasks = _uponCompletionTasks; // array, contains names of tasks to be released when signal is completed
	
	static getSignalID = function() {
		return signalID;
	}
	
	static getName = function() {
		return name;
	}
	
	static getAudioData = function() { // convert struct into an ARRAY,
		return [audioData[$ "AnswerAudioFile"], audioData[$ "UpperAudioFile"], audioData[$ "LowerAudioFile"], audioData[$ "NoiseFile"]];
	}
	
	static getSolutionData = function() { // convert struct into array
		return [solutionData[$ "Location"], solutionData[$ "MinimumDistance"], solutionData[$ "UpperPitchAnswer"], solutionData[$ "LowerPitchAnswer"], solutionData[$ "UpperGainAnswer"], solutionData[$ "LowerGainAnswer"]];
	
	}
	
	static getUponCompletionTasks = function() {
		return uponCompletionTasks;
	}
	
	static isTimeEligible = function(currentTime) {
		show_debug_message(string(currentTime) + " " + string(minimumTimeElapsed));
		if (currentTime >= minimumTimeElapsed) {
			return true;
		}
		else {
			return false;
		}
	}
	
	static getHasBeenReleased = function() {
		return hasBeenReleased;
	}
	
	static updateHasBeenReleased = function(state) {
		hasBeenReleased = state;
	}

}