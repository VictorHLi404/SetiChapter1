upperAudioMV = global.INT_MAX;
upperAudioID = global.INT_MAX;
lowerAudioMV = global.INT_MAX;
lowerAudioID = global.INT_MAX;
noiseAudioMV = global.INT_MAX;
noiseAudioID = global.INT_MAX;
audioData = []; // array to be updated with the relavent data whenever a signal is switched
// [answeraudio, upper, lower, noise]

bottomRange = 900; // borders of how far the soundbar should go
topRange = 775;
leftRange = 750;
rightRange = 1400;
maxHeight = (bottomRange-topRange)/2; // max height of the soundbars
centerLine = bottomRange-maxHeight; // center of the display

numberOfBars = 36;
barWidth = 15; // width of bar and space between bars
spacer = 5;

fftSize = 16000; // change to lag out the game o rnot
maxFrequencyAmplitude = 800; // controls the waveiness / sensitivity of the bar

isCurrentlyPlaying = false;
isCurrentlyDrawn = false;

gainAdjustmentValues = [0.5, 0.5];
pitchAdjustmentValues = [1, 1];

displayDataHandler = obj_scannerScreenDataHandler.dataHandler;
displayTemplateFile = "bootScreenButtonTemplate.json";

function isSoundLoaded() {
	if (array_length(audioData) > 0) {
		return true;
	}
	else {
		return false;
	}
}

function createPlayButtonInstance() {
	var newButtonID = "ResponsePlayerPlayButton";
	var newButton = new createButton(x+630, y+30, 55, 55, "_", displayDataHandler, displayTemplateFile, newButtonID);
	playButtonInstance = instance_create_layer(x+630, y+30, "Instances", obj_button);
	with (playButtonInstance) {
		buttonID = newButtonID;
		button = newButton;
		depth = -10000;
		image_xscale = 0.86;
		image_yscale = 0.86;
		uniqueButtonEvent = function() {
			if (obj_scannerScreenStarmapCursor.getIsPlaced() == true) {
				obj_playerResponsePlayer.playResponseSound();	
			}
			obj_answerPlayer.stopPlayingSound();
		}
	}
}

function createPauseButtonInstance() {
	var newButtonID = "ResponsePlayerPauseButton";
	var newButton = new createButton(x+630, y+95, 55, 55, "_", displayDataHandler, displayTemplateFile, newButtonID);
	playButtonInstance = instance_create_layer(x+630, y+95, "Instances", obj_button);
	with (playButtonInstance) {
		buttonID = newButtonID;
		button = newButton;
		depth = -10000;
		image_xscale = 0.86;
		image_yscale = 0.86;
		uniqueButtonEvent = function() {
			obj_playerResponsePlayer.stopPlayingSound();
		}
	}
}


function getIsCurrentlyPlaying() {
	return isCurrentlyPlaying;
}

function setIsCurrentlyPlaying(state) {
	isCurrentlyPlaying = state;
}


function stopPlayingSound() {
	if (getIsCurrentlyPlaying()) {
		show_debug_message("STOP PLAYING SOUND");
		isCurrentlyPlaying = false;
		isCurrentlyDrawn = false;
		audio_stop_sound(audioFilenameToSource(audioData[1]));
		audio_stop_sound(audioFilenameToSource(audioData[2]));
		audio_stop_sound(audioFilenameToSource(audioData[3]));
	}
	return;
}

function updateAudioData(newAudioData) {
	if (array_length(audioData) > 0) {
		stopPlayingSound();
	}
	audioData = newAudioData;
}

function updatePlayerValues(newGainValues, newPitchValues) {
	gainAdjustmentValues = newGainValues;
	pitchAdjustmentValues = newPitchValues;
}

function playResponseSound() {
	if (isSoundLoaded()) {
		upperAudioMV = mv_load(audioData[1]); 
		upperAudioID = audio_play_sound(audioFilenameToSource(audioData[1]), 0, 0, gainAdjustmentValues[0], 0, pitchAdjustmentValues[0]);
		lowerAudioMV = mv_load(audioData[2]); 
		lowerAudioID = audio_play_sound(audioFilenameToSource(audioData[2]), 1, 0, gainAdjustmentValues[1], 0, pitchAdjustmentValues[1]);
		noiseAudioMV = mv_load(audioData[3]);
		noiseAudioID = audio_play_sound(audioFilenameToSource(audioData[3]), 2, 0, gainAdjustmentValues[2]);
		//gainAdjustmentValues = gainValues;
		//pitchAdjustmentValues = pitchValues;
		isCurrentlyPlaying = true;
		isCurrentlyDrawn = true;
		var originalTrackLength = obj_answerPlayer.getTrackLength();
		//alarm[0] = addTimeDelay(originalTrackLength); // for the loop
		alarm[1] = originalTrackLength; // for drawing the bars
	}
}

createPlayButtonInstance();
createPauseButtonInstance();