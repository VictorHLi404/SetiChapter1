/// @description Insert description here
// You can write your code in this editor



if (isDisplayActive) {
	var displayTaskList = global.taskHandler.getDisplayTaskData();
	for (var i = 0; i < global.taskHandler.getActiveTaskCount(); i++) {
		var tempTaskDisplay = variable_instance_get(instance_find(obj_taskDisplay,i),"taskDisplay");
		tempTaskDisplay.updateTaskData(displayTaskList[i]);
	}
}























