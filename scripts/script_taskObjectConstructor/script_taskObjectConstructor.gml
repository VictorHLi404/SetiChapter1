// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createTaskObject(_taskID, _taskName, _taskDescription, _taskLength, _currentProgression, _isOptimizable, _puzzleType, _puzzleCode, _taskCompletionWindow) constructor {
	taskID = _taskID; // unique identifier for each task, given by whatever process completed it, string
	taskName = _taskName; // name displayed on physical object, string
	taskDescription = _taskDescription; // description displayed on physical object, string
	taskLength = _taskLength; // length of task given in hours, integer
	currentProgression = _currentProgression; // current length of time spent on task / task has been active, integer
	isOptimizable = _isOptimizable; // whether the operation is optimizable or not, boolean
	puzzleType = _puzzleType; // metadata for next step to load the optimization puzzle, string
	puzzleCode = _puzzleCode; // metadata to load the optimization puzzle, specific code for the data, string
	taskCompletionWindow = _taskCompletionWindow; // length given to the player to complete task, autofail if not met within time
	isCurrentlyProgressing = false;
	
	static setIsCurrentlyProgressing = function(state) {
		isCurrentlyProgressing = state;
	}
	static getIsCurrentlyProgressing = function() {
		return isCurrentlyProgressing;
	}
	static checkIsBlank = function() {
		if (taskID == "BlankTask") {
			return true;
		}
		else {
			return false;
		}
	}
	
	static progressTask = function() {
		if (isCurrentlyProgressing) {
			currentProgression++;
		}	
		taskCompletionWindow--;
		return;
	}
	
	static evaluateTask = function() {
		if (currentProgression >= taskLength) {
			return ("TASK COMPLETE");	
		}
		else if (taskCompletionWindow <= 0) {
			return ("TASK TIMED OUT");
		}
		else {
			return ("NO UPDATE");
		}
	}
	
	static modifyTaskLength = function(taskLengthMultiplier) {
		taskLength = floor(taskLengthMultiplier*taskLength);
	}	
	
	static getTaskID = function() {
		return taskID;
	}
	
	static getTaskName = function() {
		return taskName;	
	}
	
	static getTaskDescription = function() {
		return taskDescription;
	}
	
	static getTaskLength = function() {
		return taskLength;
	}
	
	static getCurrentProgression = function() {
		return currentProgression;
	}
	
	static getIsOptimizable = function() {
		return isOptimizable;
	}
	
	static getPuzzleType = function() {
		return puzzleType;
	}
	
	static getPuzzleCode = function() {
		return puzzleCode;
	}
	
	static getRemainingTime = function() {
		return taskCompletionWindow;
	}
}