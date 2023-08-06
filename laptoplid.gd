extends StaticBody3D


@export var mode = true


func _on_mouse_entered() -> void:
    $"../../../cur".visible = true
    $"../../../cur".play("close")


func _on_mouse_exited() -> void:
    $"../../../cur".visible = false


func _on_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
    if event is InputEventMouseButton:
        if event.pressed:
            if mode:
                $"../../../armanims".play("panicc")
            else:
                $"../../../armanims".play("un panicc")
