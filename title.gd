extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _on_play_pressed() -> void:
    get_tree().change_scene_to_file("res://game_main.tscn")


func _on_settings_pressed() -> void:
    pass # Replace with function body.


func _on_credits_pressed() -> void:
    pass # Replace with function body.
