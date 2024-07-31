// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function audioFilenameToSource (fileName) {
	var fileReference = {
		"_1.ogg" : _1,
		"_2.ogg" : _2,
		"_3.ogg" : _3,
		"_4.ogg" : _4,
		"_5.ogg" : _5,
		"_6.ogg" : _6,
		"testnoise.ogg" : testnoise
	}
	return fileReference[$ fileName];
}

function normalizeHeight(length, maxHeight) {
	var maxFrequencyAmplitude = 100;
	var normalizedLength = (power(length,1/2)/power(maxFrequencyAmplitude,1/2))*maxHeight;
	if (normalizedLength > maxHeight) {
		return maxHeight;
	}
	return normalizedLength;
}

function getFrequency(barNumber) { // APPROXIMATE CUBIC FUNCTION (x^3)/12 TO MAKE IT FIT THE CUBIC A BIT BETTER
	return floor(power(barNumber+10, 3)/25);
}

function getSoundFrameLength(audioID) {
	return floor(audio_sound_length(audioID)*game_get_speed(gamespeed_fps))-1;
}

function getSoundPlaytimeLength(audioID) {
	var timeDelay = 1;
	return getSoundFrameLength(audioID) + timeDelay*game_get_speed(gamespeed_fps);
}

function addTimeDelay(trackLength) {
	var timeDelay = 1;
	return trackLength + timeDelay*game_get_speed(gamespeed_fps);
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

function getBarLength(frequencyArray, index, gain, pitch) {
	var maxFrequency = 16000;
	var adjustedFrequency = (1/pitch)*getFrequency(index);
	if (adjustedFrequency > maxFrequency) {
		adjustedFrequency = maxFrequency-1;
	}
	return frequencyArray[adjustedFrequency]*(gain+0.2);
}