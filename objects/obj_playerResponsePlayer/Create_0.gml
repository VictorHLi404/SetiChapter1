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


function stopPlayingSound() {
	isCurrentlyDrawn = false;
	audio_stop_sound(audioFilenameToSource(audioData[1]));
	audio_stop_sound(audioFilenameToSource(audioData[2]));
	audio_stop_sound(audioFilenameToSource(audioData[3]));
}

function setIsCurrentlyPlaying(state) {
	isCurrentlyPlaying = state;
}

function updateAudioData(newAudioData) {
	if (array_length(audioData) > 0) {
		stopPlayingSound();
	}
	audioData = newAudioData;
}

function playResponseSound(gainValues, pitchValues) {
		upperAudioMV = mv_load(audioData[1]); 
		upperAudioID = audio_play_sound(audioFilenameToSource(audioData[1]), 0, 0, gainValues[0], 0, pitchValues[0]);
		lowerAudioMV = mv_load(audioData[2]); 
		lowerAudioID = audio_play_sound(audioFilenameToSource(audioData[2]), 1, 0, gainValues[1], 0, pitchValues[1]);
		noiseAudioMV = mv_load(audioData[3]);
		noiseAudioID = audio_play_sound(audioFilenameToSource(audioData[3]), 2, 0, gainValues[2]);
		gainAdjustmentValues = gainValues;
		pitchAdjustmentValues = pitchValues;
		isCurrentlyPlaying = true;
		isCurrentlyDrawn = true;
		var originalTrackLength = obj_answerPlayer.getTrackLength();
		alarm[0] = addTimeDelay(originalTrackLength); // for the loop
		alarm[1] = originalTrackLength; // for drawing the bars
}

