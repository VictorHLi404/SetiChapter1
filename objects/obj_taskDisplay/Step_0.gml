/// @description Insert description here
// You can write your code in this editor
taskDisplay.checkIsBlank();
taskNameDisplayField.updateText(taskDisplay.getTaskName());
taskDescriptionDisplayField.updateText(taskDisplay.getTaskDescription());
taskRemainingTimeDisplayField.updateText(taskDisplay.getRemainingTime());
completionRatio = taskDisplay.getCompletion();

if (dataIsLoaded) {
	if (taskDisplay.getTaskID() != runningTaskID) { // if new variable has been introduced
		instance_destroy(taskButtonInstance);
		instance_destroy(optimizeButtonInstance);
		taskButtonInstance = noone; // reset buttons and destroy associated struct (?)
		optimizeButtonInstance = noone;
		taskDisplay.checkIsBlank();

		if (!taskDisplay.getIsBlank()) { // if task exists for slot
			createTaskButtonInstance();
			if (taskDisplay.getIsOptimizable() == true) { // if task is optimizable
				createOptimizeButtonInstance();
			}
		}
		runningTaskID = taskDisplay.getTaskID();
	}
}


















