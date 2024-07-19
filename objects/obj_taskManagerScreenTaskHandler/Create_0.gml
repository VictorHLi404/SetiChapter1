/// @description Insert description here
// You can write your code in this editor

global.taskHandler = new createTaskHandler(["TaskRepository.json", "TaskStoredQueue.json", "TaskCompletionMap.json"]);
global.taskHandler.initializeQueue();

isActive = false; // whether its counting ticks to update new things
isDisplayActive = false; // whether its sending display updates to the task displays




















