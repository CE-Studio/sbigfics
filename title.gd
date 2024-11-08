extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/intro.tscn")


func _on_settings_pressed() -> void:
	$"Control/Options".visible = true


func _on_credits_pressed() -> void:
	$"Control/Credits".visible = true


func _on_return_to_menu() -> void:
	$"Control/Options".visible = false
	$"Control/Credits".visible = false
