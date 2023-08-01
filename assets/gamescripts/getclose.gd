extends Game


const basespeed := 300.0
const scorescale := 1.0


func _ready() -> void:
    pass # Replace with function body.


func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.pressed:
            score += (($Sprite2D3.position.x / 2) - 100)
            endgame()


func _process(delta: float) -> void:
    $Sprite2D3.position.x += abs((basespeed * delta) + (scorescale * Game.score * delta))
    if $Sprite2D3.position.x > 512:
        endgame()
