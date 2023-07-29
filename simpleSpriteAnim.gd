extends Sprite3D

@export var framecount:int = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    frame = roundi((Time.get_ticks_msec() / 1000.0) * 3.0) % framecount
