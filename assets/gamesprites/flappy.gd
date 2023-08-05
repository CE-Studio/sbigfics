extends Game


func _process(delta: float) -> void:
    Game.score += (delta * 5)


func _on_audio_stream_player_finished() -> void:
    endgame()
