// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createTaskDisplayObject(_type, _x, _y, _imageAngle, _active, _taskData) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor{
	taskData = _taskData; // taskObject struct
	isBlank = false; // keep track of whether to display as blank task or show current data
	
	static checkIsBlank = function() {
		isBlank = taskData.checkIsBlank();
	}
	
	static getIsBlank = function() {
		return isBlank;	
	}
	
	static updateTaskData = function(newTaskData) {
		taskData = newTaskData;
	}
	
	static getIsCurrentlyProgressing = function() {
		return taskData.getIsCurrentlyProgressing();
	}
	
	static getTaskID = function() {
		return taskData.getTaskID();	
	}
	
	static getTaskName = function() {
		return taskData.getTaskName();
	}
	
	static getTaskDescription = function() {
		return taskData.getTaskDescription();
	}
	
	static getCompletion = function() { // float of ratio between completed length and remaining
		return taskData.getCurrentProgression()/taskData.getTaskLength();
	}
	
	static getIsOptimizable = function() {
		return taskData.getIsOptimizable();
	}
	
	static getRemainingTime = function() {
		return taskData.getRemainingTime();
	}
}