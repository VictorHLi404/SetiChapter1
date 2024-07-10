var frequencyData = mv_get_data(AudioIDinMV,audio_sound_get_track_position(AudioID),audio_sound_length(AudioID), fftSize);

for (var i = 0; i < numberOfBars; i++) {
	var length = normalizeHeight(frequencyData[getFrequency(i)]);
	var startPoint = leftRange+(i*barWidth);
	draw_rectangle(startPoint, centerLine, startPoint+barWidth-spacer, centerLine - length, 0);
	draw_rectangle(startPoint, centerLine, startPoint+barWidth-spacer, centerLine + length, 0);
}

// one loop to pull accurate length data from the file, one loop to display