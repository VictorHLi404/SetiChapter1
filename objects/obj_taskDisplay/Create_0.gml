/// @description Insert description here
// You can write your code in this editor

taskDisplay = new createTaskDisplayObject("TaskDisplay", x, y, image_angle, true, global.taskHandler.getBlankTask());
displayDataHandler = obj_taskManagerScreenDataHandler.dataHandler;
displayTemplateFile = "bootScreenButtonTemplate.json";
taskNameDisplayField = new createTextDisplay(x+30, y+30, 700, 50, taskDisplay.getTaskName(), displayDataHandler, displayTemplateFile);
taskDescriptionDisplayField = new createTextDisplay(x+30, y+100, 1000, 50, taskDisplay.getTaskDescription(), displayDataHandler, displayTemplateFile);

completionRatio = taskDisplay.getCompletion();
completionBarHeight = 50;
completionBarLength = 400;


















