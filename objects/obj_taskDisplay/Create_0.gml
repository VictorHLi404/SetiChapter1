/// @description Insert description here
// You can write your code in this editor

taskDisplay = new createTaskDisplayObject("TaskDisplay", x, y, image_angle, true, global.taskHandler.getBlankTask());
displayDataHandler = obj_taskManagerScreenDataHandler.dataHandler;
displayTemplateFile = "bootScreenButtonTemplate.json";
uniqueTaskID = "";

taskNameDisplayField = new createTextDisplay(x+30, y+30, 700, 50, taskDisplay.getTaskName(), displayDataHandler, displayTemplateFile);
taskDescriptionDisplayField = new createTextDisplay(x+30, y+100, 1000, 50, taskDisplay.getTaskDescription(), displayDataHandler, displayTemplateFile);
taskRemainingTimeDisplayField = new createTextDisplay(x+800, y+100, 200, 50, taskDisplay.getRemainingTime(), displayDataHandler, displayTemplateFile);

taskButtonInstance = noone;
optimizeButtonInstance = noone;

dataIsLoaded = false;
alarm[0] = 2;

completionRatio = taskDisplay.getCompletion();
completionBarHeight = 50;
completionBarLength = 400;

runningTaskID = "";

function createTaskButtonInstance() { // need to update so that the text keeps u p with swapping 
	var enableTaskButtonID = "EnableButton"+uniqueTaskID;
	var enableTaskButton = new createStateButton(x+1000, y+100, 200, 50, "DISABLED", displayDataHandler, displayTemplateFile, enableTaskButtonID, taskDisplay.getIsCurrentlyProgressing());
	taskButtonInstance = instance_create_layer(x+1000, y+100, "Instances", obj_button);

	with (taskButtonInstance) {
		button = enableTaskButton;
		buttonID = enableTaskButtonID;
		depth = -1000; // make sure that its drawn on top of current object
		image_xscale = 3.2;
		image_yscale = 0.8;
		
		uniqueButtonEvent = function() {
			var index = real(string_copy(buttonID, string_length(buttonID), 1))-1; // get index from the name of the display task
			show_debug_message("TASK DISPLAY INDEX" + string(index));
			button.setInternalState(!button.getInternalState()); // flip the state
			global.taskHandler.setTaskProgression(index, button.getInternalState()); // update the main index
			
			if (button.getInternalState() == true) {
				button.updateText("ENABLED");
			}
			else {
				button.updateText("DISABLED");
			}
		}
	}

}

function createOptimizeButtonInstance() {
	var optimizeTaskButtonID = "OptimizeButton"+uniqueTaskID;
	var optimizeTaskButton = new createButton(x+1220, y+100, 200, 50, "H", displayDataHandler, displayTemplateFile,optimizeTaskButtonID);
	optimizeButtonInstance = instance_create_layer(x+1220, y+100, "Instances", obj_button);
	
	with (optimizeButtonInstance) {
		button = optimizeTaskButton;
		buttonID = optimizeTaskButtonID;
		depth = -1000;
		image_xscale = 3.2;
		image_yscale = 0.8;
			
		uniqueButtonEvent = function() {
			var index = real(string_copy(buttonID, string_length(buttonID), 1))-1 // same as above
			global.taskHandler.loadPuzzle(index);
		}
	}
}














