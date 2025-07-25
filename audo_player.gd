class_name AudioPlayer

static func play(audio: AudioStream, pitch := 1.0) -> void:
	var audio_player := AudioStreamPlayer2D.new()
	audio_player.stream = audio
	audio_player.pitch_scale = pitch
	Engine.get_main_loop().root.add_child(audio_player)
	audio_player.play()
	await audio_player.finished
	audio_player.queue_free()
