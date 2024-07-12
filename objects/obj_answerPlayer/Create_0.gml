AudioIDinMV = global.INT_MAX;
AudioID = global.INT_MAX;
trackLength = global.INT_MIN;

bottomRange = 900; // borders of how far the soundbar should go
topRange = 775;
leftRange = 100;
rightRange = 600;
maxHeight = (bottomRange-topRange)/2; // max height of the soundbars
centerLine = bottomRange-maxHeight; // center of the display

numberOfBars = 36;
barWidth = 15; // width of bar and space between bars
spacer = 5;

fftSize = 16000; // change to lag out the game o rnot
maxFrequencyAmplitude = 800; // controls the waveiness / sensitivity of the bar

isCurrentlyPlaying = false; // keeps track of whether audio is going or not
isCurrentlyDrawn = false; // keeps track of whether visualizer is running or not

function setIsCurrentlyPlaying(state) {
	isCurrentlyPlaying = state;
}

function getTrackLength() {
	return trackLength;
}

function getAudioID() {
	return AudioID;
}

function playAnswerSound() {
	AudioIDinMV = mv_load(@"testchords.ogg"); 
	AudioID = audio_play_sound(testchords,0, 0, 0.5);
	isCurrentlyPlaying = true;
	isCurrentlyDrawn = true;
	trackLength = getSoundFrameLength(AudioID);
	alarm[0] = getSoundPlaytimeLength(AudioID); // for the loop
	alarm[1] = getSoundFrameLength(AudioID); // for drawing the bars
}

playAnswerSound(); // when first loading into room, play off rip