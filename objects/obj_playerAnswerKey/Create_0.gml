upperAudioMV = global.INT_MAX;
upperAudioID = global.INT_MAX;
lowerAudioMV = global.INT_MAX;
lowerAudioID = global.INT_MAX;


bottomRange = 900; // borders of how far the soundbar should go
topRange = 775;
leftRange = 750;
rightRange = 1400;
maxHeight = (bottomRange-topRange)/2; // max height of the soundbars
centerLine = bottomRange-maxHeight; // center of the display

numberOfBars = 24;
barWidth = 20; // width of bar and space between bars
spacer = 5;

fftSize = 16000; // change to lag out the game o rnot
maxFrequencyAmplitude = 800; // controls the waveiness / sensitivity of the bar

isCurrentlyPlaying = false;
isCurrentlyDrawn = false;

function setIsCurrentlyPlaying(state) {
	isCurrentlyPlaying = state;
}

function playSound() {
	upperAudioMV = mv_load(@"testchordsupperhalf.ogg"); 
	upperAudioID = audio_play_sound(testchordsupperhalf, 0, 0, 1);
	lowerAudioMV = mv_load(@"testchordslowerhalf.ogg"); 
	lowerAudioID = audio_play_sound(testchordslowerhalf, 0, 0, 1);
	isCurrentlyPlaying = true;
	isCurrentlyDrawn = true;
	alarm[0] = getSoundPlaytimeLength(upperAudioID); // for the loop
	alarm[1] = getSoundFrameLength(upperAudioID); // for drawing the bars
}