extends AnimatableBody2D


const basespeed := 200.0
const scorescale := 1.0


func _process(delta: float) -> void:
    position.x -= (basespeed * delta) + (scorescale * Game.score * delta)
    if position.x < -592:
        position.x = 592
        position.y = randi_range(-296, 296)
