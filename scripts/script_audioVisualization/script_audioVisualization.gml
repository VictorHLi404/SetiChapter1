// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function normalizeHeight(length, maxHeight) {
	var maxFrequencyAmplitude = 800;
	var normalizedLength = (power(length,1/2)/power(maxFrequencyAmplitude,1/3))*maxHeight;
	if (normalizedLength > maxHeight) {
		return maxHeight;
	}
	return normalizedLength;
}

function getFrequency(barNumber) { // APPROXIMATE CUBIC FUNCTION (x^3)/12 TO MAKE IT FIT THE CUBIC A BIT BETTER
	return floor(power(barNumber+7, 3)/12);
}

function getSoundFrameLength(audioID) {
	return floor(audio_sound_length(audioID)*game_get_speed(gamespeed_fps))-1;
}

function getSoundPlaytimeLength(audioID) {
	var timeDelay = 3;
	return getSoundFrameLength(audioID) + timeDelay*game_get_speed(gamespeed_fps);
}

function visualizeAudio(numberOfBars, barLengths, leftRange, centerLine, barWidth, spacer) {
	for (var i = 0; i < numberOfBars; i++) {
		var startPoint = leftRange+(i*barWidth);
		draw_rectangle(startPoint, centerLine, startPoint+barWidth-spacer, centerLine - barLengths[i], 0);
		draw_rectangle(startPoint, centerLine, startPoint+barWidth-spacer, centerLine + barLengths[i], 0);
	}
}

function drawBlankAudioVisualizer(numberOfBars, leftRange, centerLine, barWidth, spacer) {
	for (var i = 0; i < numberOfBars; i++) {
		var startPoint = leftRange+(i*barWidth);
		draw_rectangle(startPoint, centerLine, startPoint+barWidth-spacer, centerLine-1, 0);
		draw_rectangle(startPoint, centerLine, startPoint+barWidth-spacer, centerLine+1, 0);
	}
}