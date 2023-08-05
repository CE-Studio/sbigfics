extends StaticBody3D


@onready var _vp:SubViewport = $"../../../SubViewport"


func remap_range(value, InputA, InputB, OutputA, OutputB):
    return(value - InputA) / (InputB - InputA) * (OutputB - OutputA) + OutputA


func _on_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
    var pos = Vector2(round(remap_range(position.x, -0.713, 0.713, 0, 1024)),
                      round(remap_range(position.y, 0.09, 1.225, 910, 0)))
    var ev:InputEvent = event.duplicate()
    ev.position = pos
    _vp.push_input(ev)


func _on_mouse_entered() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _on_mouse_exited() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
