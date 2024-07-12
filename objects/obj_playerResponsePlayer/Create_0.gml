upperAudioMV = global.INT_MAX;
upperAudioID = global.INT_MAX;
lowerAudioMV = global.INT_MAX;
lowerAudioID = global.INT_MAX;
noiseAudioMV = global.INT_MAX;
noiseAudioID = global.INT_MAX;

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
function setIsCurrentlyPlaying(state) {
	isCurrentlyPlaying = state;
}

function playResponseSound(gainValues, pitchValues) {
		upperAudioMV = mv_load(@"testchordsupperhalf.ogg"); 
		upperAudioID = audio_play_sound(testchordsupperhalf, 0, 0, gainValues[0], 0, pitchValues[0]);
		lowerAudioMV = mv_load(@"testchordslowerhalf.ogg"); 
		lowerAudioID = audio_play_sound(testchordslowerhalf, 1, 0, gainValues[1], 0, pitchValues[1]);
		noiseAudioMV = mv_load(@"testnoise.ogg");
		noiseAudioID = audio_play_sound(testnoise, 2, 0, gainValues[2]);
		gainAdjustmentValues = gainValues;
		pitchAdjustmentValues = pitchValues;
		isCurrentlyPlaying = true;
		isCurrentlyDrawn = true;
		var originalTrackLength = obj_answerPlayer.getTrackLength();
		alarm[0] = addTimeDelay(originalTrackLength); // for the loop
		alarm[1] = originalTrackLength; // for drawing the bars
}