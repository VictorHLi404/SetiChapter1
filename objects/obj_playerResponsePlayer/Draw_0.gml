if (isCurrentlyDrawn) {
	var upperFrequencyData = mv_get_data(upperAudioMV,audio_sound_get_track_position(upperAudioID),audio_sound_length(upperAudioID), fftSize);
	var lowerFrequencyData = mv_get_data(lowerAudioMV,audio_sound_get_track_position(lowerAudioID),audio_sound_length(lowerAudioID), fftSize);
	var noiseData = mv_get_data(noiseAudioMV,audio_sound_get_track_position(noiseAudioID),audio_sound_length(noiseAudioID), fftSize);
	var barLengths = [];

	for (var i = 0; i < numberOfBars; i++) {
		barLengths[i] = normalizeHeight(getBarLength(upperFrequencyData, i, gainAdjustmentValues[0], pitchAdjustmentValues[0]) + getBarLength(lowerFrequencyData, i, gainAdjustmentValues[1], pitchAdjustmentValues[1])/*+ getBarLength(noiseData, i, gainAdjustmentValues[2], 1)*/, maxHeight);
	}
	visualizeAudio(numberOfBars, barLengths, leftRange, centerLine, barWidth, spacer);
}
else {
	drawBlankAudioVisualizer(numberOfBars, leftRange, centerLine, barWidth, spacer);
}






















