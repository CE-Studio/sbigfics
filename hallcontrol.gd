extends Node3D


@onready var chars:Array = get_children()
@export var caughtpos := Vector3.ZERO
@export var caughtrot := Vector3.ZERO
@export var doorclosed := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func send():
    var h = chars.pick_random()
    h.flip_h = !h.flip_h
    $"../halltime".wait_time = randf_range(10, 40)
    $"../halltime".start()
    $"../halldoorsound".play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if not Engine.is_editor_hint():
        for i in chars:
            if i.flip_h:
                i.position.x = clampf(i.position.x + (5 * delta), -20, 20)
            else:
                i.position.x = clampf(i.position.x - (5 * delta), -20, 20)
    else:
        pass
