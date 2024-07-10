AudioIDinMV = mv_load(@"testchords.ogg"); 
AudioID = audio_play_sound(testchords,0,1);
bottomRange = 900; // borders of how far the soundbar should go
topRange = 775;
leftRange = 100;
rightRange = 600;
maxHeight = (bottomRange-topRange)/2; // max height of the soundbars
centerLine = bottomRange-maxHeight;

numberOfBars = 24;
barWidth = 20; // width of bar and space between bars
spacer = 5;

fftSize = 44100;
maxFrequencyAmplitude = 800; // controls the waveiness / sensitivity of the bar

function normalizeHeight(length) {
	var normalizedLength = (power(length,1/3)/power(maxFrequencyAmplitude,1/3))*maxHeight;
	if (normalizedLength > maxHeight) {
		return maxHeight;
	}
	return normalizedLength;
}

function getFrequency(barNumber) { // APPROXIMATE CUBIC FUNCTION (x^3)/12 TO MAKE IT FIT THE CUBIC A BIT BETTER
	return floor(power(barNumber+7, 3)/12);
}