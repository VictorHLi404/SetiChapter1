// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createPuzzleHandler(_fileList) : createDataHandler(_fileList) constructor {
	/*
	Responsible for handling puzzle name strings and sending them off to room builder to construct
	generating the amount of resources available to the player for the current puzzle
	providing display data to the display fields on the puzzle screen
	counting how many puzzle attempts the player currently has an whether they can regenrate or not (?)
	interfaces with taskmanager, loadmanager, and playerhandler data objects
	*/
	
	maximumPuzzleAttempts = 5;
	currentPuzzleAttempts = 5;
	currentPuzzleCode = "";
	
	
	static recordPuzzleAttempt = function() { // subtract one from current puzzle attempts when bullet fired
		currentPuzzleAttempts = max(0, currentPuzzleAttempts-1);
		return;
	}
	
	static isAttemptValid = function() { // check if there are puzzle attempts left to give
		if (currentPuzzleAttempts > 0) {
			return true;
		}
		else {
			show_debug_message("NO MORE BULLETS");
			return false;
		}
	}
	
	static regenerateAttempt = function() { // regenerate 1 attempt every day / 24 hours
		currentPuzzleAttempts = min(maximumPuzzleAttempts, currentPuzzleAttempts+1);
		return;
	}
	
	static updateCurrentPuzzleCode = function(newPuzzleCode) { // change current puzzle code to be loaded in battle room
		currentPuzzleCode = newPuzzleCode;
	}
	
	static getCurrentPuzzleCode = function() { // getter
		return currentPuzzleCode;
	}
	
	static getRefundReward = function(refundAmount) { // reload current puzzle attempts depending on value from puzzle
		currentPuzzleAttempts = min(maximumPuzzleAttempts, currentPuzzleAttempts+refundAmount);
	}
	
	static getDisplayData = function() { // get display data for the current puzzle code based off of puzzle repository
		
	}
	
}