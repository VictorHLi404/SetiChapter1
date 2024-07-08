var k = mv_get_data(AudioIDinMV,audio_sound_get_track_position(AudioID),audio_sound_length(AudioID), 4096)
for(var i = 0; i < array_length(k);i+=10){
	var length = k[i]
	draw_rectangle(i,room_height,i+5,room_height - length*10,0)
}