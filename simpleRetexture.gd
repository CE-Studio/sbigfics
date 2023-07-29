extends TextureRect


@export var frames:Array[Texture2D]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    texture = frames[roundi((Time.get_ticks_msec() / 1000.0) * 3.0) % (frames.size())]
