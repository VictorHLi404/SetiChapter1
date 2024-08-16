AudioIDinMV = global.INT_MAX;
AudioID = global.INT_MAX;
trackLength = global.INT_MIN;
audioData = []; // array to be updated with the relavent data whenever a signal is switched
// [answeraudio, upper, lower, noise]

bottomRange = 900; // borders of how far the soundbar should go
topRange = 775;
leftRange = 50;
rightRange = 500;
maxHeight = (bottomRange-topRange)/2; // max height of the soundbars
centerLine = bottomRange-maxHeight; // center of the display

numberOfBars = 36;
barWidth = 15; // width of bar and space between bars
spacer = 5;

fftSize = 16000; // change to lag out the game o rnot
maxFrequencyAmplitude = 800; // controls the waveiness / sensitivity of the bar

isCurrentlyPlaying = false; // keeps track of whether audio is going or not
isCurrentlyDrawn = false; // keeps track of whether visualizer is running or not

playButtonInstance = noone;
pauseButtonInstance = noone;

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
	var newButtonID = "AnswerPlayerPlayButton";
	var newButton = new createButton(x+630, y+30, 55, 55, "_", displayDataHandler, displayTemplateFile, newButtonID);
	playButtonInstance = instance_create_layer(x+630, y+30, "Instances", obj_button);
	with (playButtonInstance) {
		buttonID = newButtonID;
		button = newButton;
		depth = -10000;
		image_xscale = 0.86;
		image_yscale = 0.86;
		uniqueButtonEvent = function() {
			obj_playerResponsePlayer.stopPlayingSound();
			obj_answerPlayer.playAnswerSound();
		}
	}
}

function createPauseButtonInstance() {
	var newButtonID = "AnswerPlayerPauseButton";
	var newButton = new createButton(x+630, y+95, 55, 55, "_", displayDataHandler, displayTemplateFile, newButtonID);
	playButtonInstance = instance_create_layer(x+630, y+95, "Instances", obj_button);
	with (playButtonInstance) {
		buttonID = newButtonID;
		button = newButton;
		depth = -10000;
		image_xscale = 0.86;
		image_yscale = 0.86;
		uniqueButtonEvent = function() {
			obj_answerPlayer.stopPlayingSound();
		}
	}
}

function getIsCurrentlyPlaying() {
	return isCurrentlyPlaying;
}

function setIsCurrentlyPlaying(state) {
	isCurrentlyPlaying = state;
}

function getTrackLength() {
	return trackLength;
}

function getAudioID() {
	return AudioID;
}

function stopPlayingSound() {
	if (getIsCurrentlyPlaying()) {
		isCurrentlyDrawn = false;
		isCurrentlyPlaying = false;
		audio_stop_sound(audioFilenameToSource(audioData[0]));
	}

	return;
}

function updateAudioData(newAudioData) {
	if (array_length(audioData) > 0) {
		stopPlayingSound();
	}
	audioData = newAudioData;
	AudioID = audio_play_sound(audioFilenameToSource(audioData[0]), 0, 0, 0);
	trackLength = getSoundFrameLength(AudioID);
	audio_stop_sound(audioFilenameToSource(audioData[0]));
	show_message("NEW TRACK LENGTH IS " + string(trackLength));
}


function playAnswerSound() {
	if (isSoundLoaded()) {
		AudioIDinMV = mv_load(audioData[0]); 
		AudioID = audio_play_sound(audioFilenameToSource(audioData[0]), 0, 0, 0.5);
		isCurrentlyPlaying = true;
		isCurrentlyDrawn = true;
		trackLength = getSoundFrameLength(AudioID);
		//alarm[0] = getSoundPlaytimeLength(AudioID); // for the loop
		//alarm[1] = getSoundFrameLength(AudioID); // for drawing the bars
	}
}

createPlayButtonInstance();
createPauseButtonInstance();
