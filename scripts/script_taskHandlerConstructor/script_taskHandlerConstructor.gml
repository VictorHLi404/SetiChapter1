// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createTaskHandler(_fileList) : createDataHandler(_fileList) constructor {
	taskRepository = fileData[$ fileNames[0]]; // big list of all of the tasks possible in the gmae
	taskStoredQueue = fileData[$ fileNames[1]]; // list that stores the previous order of tasks from last game load
	taskCompletionMap = fileData[$ fileNames[2]]; // map that stores whether tasks were completed or not
	
	taskQueue = new createQueue(); // queue that stores the data for active tasks
	blankTask = new createTaskObject("BlankTask", "", "", 0, 0, false, "", "", 0); // blank task used to pass when current queue is not long enough
	activeTaskCount = 4; // variable that keeps count of how many display objects and concurrent tasks can be running at a time
	

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
		dataArray[8] = JSONStruct[$ "TaskCompletionWindow"];
		return dataArray;
	}
	
	static initializeQueue = function() { // look through the stored task queue and load into the current list (I THINK IT SCRAMBLES ORDER)
		var queueLength = struct_names_count(taskStoredQueue);
		var queueNames = struct_get_names(taskStoredQueue);
		for (var i = 0; i < queueLength; i++) {
			var storedTaskData = decompileJSON(taskStoredQueue[$ queueNames[i]]);
			var storedTask = new createTaskObject(storedTaskData[0], storedTaskData[1], storedTaskData[2], storedTaskData[3], storedTaskData[4],
													storedTaskData[5], storedTaskData[6], storedTaskData[7], storedTaskData[8]);
			storedTask.setIsCurrentlyProgressing(false);
			taskQueue.append(storedTask);
		}
		return;
	}
	
	static appendToQueueFromJSONFile = function(taskID) { // look into the task repository and add from there
		var storedTaskData = decompileJSON(taskRepository[$ taskID]);
		var storedTask = new createTaskObject(storedTaskData[0], storedTaskData[1], storedTaskData[2], storedTaskData[3],
												storedTaskData[4], storedTaskData[5], storedTaskData[6], storedTaskData[7], storedTaskData[8]);
		storedTask.setIsCurrentlyProgressing(false);
		taskQueue.append(storedTask);
		return;
	}
	
	static appendToQueueFromCustom = function(taskID, taskName, taskDescription, taskLength, currentProgression, isOptimizable, puzzleType, puzzleCode, taskCompletionWindow) { // directly add a new task into the repository
		var storedTask = new createTaskObject(taskID, taskName, taskDescription, taskLength, currentProgression, isOptimizable, puzzleType, puzzleCode, taskCompletionWindow);
		storedTask.setIsCurrentlyProgressing(false);
		taskQueue.append(storedTask);
		return;
	}
	
	static getDisplayTaskData = function() { // return array that contains the active 4 tasks / visible 4 tasks
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
	
	static getBlankTask = function() { // return a blank task to be used by display objects when theyre holding nothing
		return blankTask;
	}
	
	static getActiveTaskCount = function() {
		return activeTaskCount;
	}
	
	static setTaskProgression = function(index, state) { // set tasks to be currently progressing
		var taskToBeUpdated = taskQueue.getItem(index);
		taskToBeUpdated.setIsCurrentlyProgressing(state);
		return;
	}
	
	static loadPuzzle = function(index) {
		var puzzleCode = taskQueue.getItem(index).getPuzzleCode();
		var puzzleType = taskQueue.getItem(index).getPuzzleType();
		show_message("GO TO PUZZLE ROOM WITH " + puzzleType + " AND CODE " + puzzleCode);
		return;
	}
	
	static progressTasks = function() { // advance all tasks by 1 tick
		for (var i = 0; i < taskQueue.getLength(); i++) {
			taskQueue.getItem(i).progressTask();
		}
		return;
	}
	
	static evaluateTasks = function() { // run after progresstasks, evaluate if any timers have ran out or tasks have completed
		for (var i = 0; i < taskQueue.getLength(); i++) {
			var task = taskQueue.getItem(i);
			if (task.evaluateTask() == "TASK COMPLETE") {
				updateValue(true, task.getTaskID(), "TaskCompletionMap.json");
				show_message(taskCompletionMap);
				taskQueue.removeIndex(i);
			}
			else if (task.evaluateTask() == "TASK TIMED OUT") {
				updateValue(true, task.getTaskID(), "TaskCompletionMap.json");
				taskQueue.removeIndex(i);
			}
		}
		return;
	}
	
	// integration with loadmanagerhandler for fixing corrupted tasks
	
	static convertCellIDToTaskID = function(cellID) { // string to string, takes in cellID number and turns into taskID
		var startPoint = string_last_pos("/", cellID) + 1;
		var taskID = string("CorruptedNodeRepair" + string_copy(cellID, startPoint, 4));
		return taskID;
	}
	
	static loadCorruptedNodeTask = function(cellID) {
		appendToQueueFromJSONFile(convertCellIDToTaskID(cellID));
	}
	
	static isCorruptedNodeComplete = function(cellID) {
		return taskCompletionMap[$ convertCellIDToTaskID(cellID)];
	}
}