if (isCurrentlyDrawn) {
	var frequencyData = mv_get_data(AudioIDinMV,audio_sound_get_track_position(AudioID),audio_sound_length(AudioID), fftSize);
	var barLengths = [];
	for (var i = 0; i < numberOfBars; i++) {
		barLengths[i] = normalizeHeight(getBarLength(frequencyData, i, 1, 1), maxHeight);
	}
	visualizeAudio(numberOfBars, barLengths, leftRange, centerLine, barWidth, spacer);
}
else {
	drawBlankAudioVisualizer(numberOfBars, leftRange, centerLine, barWidth, spacer);
}

// one loop to pull accurate length data from the file, one loop to display