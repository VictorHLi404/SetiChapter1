if (isCurrentlyDrawn) {
	var upperFrequencyData = mv_get_data(upperAudioMV,audio_sound_get_track_position(upperAudioID),audio_sound_length(upperAudioID), fftSize);
	var lowerFrequencyData = mv_get_data(lowerAudioMV,audio_sound_get_track_position(lowerAudioID),audio_sound_length(lowerAudioID), fftSize);
	var barLengths = [];

	for (var i = 0; i < numberOfBars; i++) {
		barLengths[i] = normalizeHeight(upperFrequencyData[getFrequency(i)]+lowerFrequencyData[getFrequency(i)], maxHeight);
	}
	visualizeAudio(numberOfBars, barLengths, leftRange, centerLine, barWidth, spacer);
}
else {
	drawBlankAudioVisualizer(numberOfBars, leftRange, centerLine, barWidth, spacer);
}






















