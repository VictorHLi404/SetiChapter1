/// @description Insert description here
// You can write your code in this editor

// offset the generation of tasks to allow the creationc ode to run first and then generate elments

taskDisplay.checkIsBlank();

if (!taskDisplay.getIsBlank()) { // if task exists for slot
	createTaskButtonInstance();
	if (taskDisplay.getIsOptimizable() == true) { // if task is optimizable
		createOptimizeButtonInstance();
	}
}

dataIsLoaded = true;















