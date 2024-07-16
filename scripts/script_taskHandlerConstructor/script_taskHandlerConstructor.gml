// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createTaskHandler(_fileList) : createDataHandler(_fileList) constructor {
	taskRepository = fileData[$ fileNames[0]]; // big list of all of the tasks possible in the gmae
	taskStoredQueue = fileData[$ fileNames[1]]; // list that stores the previous order of tasks from last game load
	taskQueue = new createQueue(); // queue that stores the data for active tasks
	blankTask = new createTaskObject("BlankTask", "", "", 0, 0, false, "", ""); // blank task used to pass when current queue is not long enough
	activeTaskCount = 4;
	

	static decompileJSON = function(JSONStruct) { // decompile a task JSON into list of attributes
		var dataArray = [];
		dataArray[0] = JSONStruct[$ "TaskID"];
		dataArray[1] = JSONStruct[$ "TaskName"];
		dataArray[2] = JSONStruct[$ "TaskDescription"];
		dataArray[3] = JSONStruct[$ "TaskLength"];
		dataArray[4] = JSONStruct[$ "CurrentProgression"];
		dataArray[5] = JSONStruct[$ "IsOptimizable"];
		dataArray[6] = JSONStruct[$ "PuzzleType"];
		dataArray[7] = JSONStruct[$ "PuzzleCode"];
		return dataArray;
	}
	
	static initializeQueue = function() {
		var queueLength = struct_names_count(taskStoredQueue);
		var queueNames = struct_get_names(taskStoredQueue);
		for (var i = 0; i < queueLength; i++) {
			var storedTaskData = decompileJSON(taskStoredQueue[$ queueNames[i]]);
			var storedTask = new createTaskObject(storedTaskData[0], storedTaskData[1], storedTaskData[2], storedTaskData[3], storedTaskData[4], storedTaskData[5], storedTaskData[6], storedTaskData[7]);
			storedTask.setIsCurrentlyProgressing(false);
			taskQueue.append(storedTask);
		}
		return;
	}
	
	static appendToQueueFromJSONFile = function(taskID) { // look into the task repository and add from there
		var storedTaskData = decompileJSON(taskRepository[$ taskID]);
		var storedTask = new createTaskObject(storedTaskData[0], storedTaskData[1], storedTaskData[2], storedTaskData[3], storedTaskData[4], storedTaskData[5], storedTaskData[6], storedTaskData[7]);
		storedTask.setIsCurrentlyProgressing(false);
		taskQueue.append(storedTask);
		return;
	}
	
	static appendToQueueFromCustom = function(taskID, taskName, taskDescription, taskLength, currentProgression, isOptimizable, puzzleType, puzzleCode) { // directly add a new task into the repository
		var storedTask = new createTaskObject(taskID, taskName, taskDescription, taskLength, currentProgression, isOptimizable, puzzleType, puzzleCode);
		storedTask.setIsCurrentlyProgressing(false);
		taskQueue.append(storedTask);
		return;
	}
	
	static getDisplayTaskData = function() {
		var tempArray = [];
		for (var i = 0; i < activeTaskCount; i++) {
			if (i >= taskQueue.getLength()) {
				tempArray[i] = blankTask;	
			}
			else {
				tempArray[i] = taskQueue.getItem(i);
			}
		}
		return tempArray;
	}
	
	static getBlankTask = function() {
		return blankTask;
	}
	
	static getActiveTaskCount = function() {
		return activeTaskCount;
	}
	
}