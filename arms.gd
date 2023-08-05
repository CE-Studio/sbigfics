extends Node3D
class_name Arms


static var playc := 0
static var mousemove := Vector2()
static var instance:Arms


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    instance = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if (playc > 0) and not $"../armanims".is_playing() and Laptop.awake:
        $"../armanims".play("type")
        playc -= 1
