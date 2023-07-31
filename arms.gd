extends Node3D
class_name Arms


static var playc := 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    $"../armanims".play("type")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if (playc > 0) and not $"../armanims".is_playing():
        $"../armanims".play("type")
        playc -= 1
