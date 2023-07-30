extends Node
class_name Game


static var score := 0.0


func endgame() -> void:
    Laptop.instance.nextgame()
