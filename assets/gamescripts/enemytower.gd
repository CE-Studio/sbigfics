extends RigidBody2D


const GROUND_Y = 812
const ADVANCE_Y = 182
var value := 0
var targetY := 0.0
var _lerpValue := 15.0
@onready var text := $"Label"
@onready var sprite := $"Sprite2D"
@onready var _player := $"../../PlayerTower/BasePlayerSegment"
@onready var button := $"TextureButton"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if targetY == 0.0:
        var index = 0
        for i in _player._enemySegments.size():
            if _player._enemySegments[i] == self:
                index = i
        var newTargetY:float = GROUND_Y - (ADVANCE_Y * index)
        position = Vector2(position.x, lerp(position.y, newTargetY, _lerpValue * delta))
    else:
        position = Vector2(lerp(position.x, 256.0, _lerpValue * delta), lerp(position.y, targetY, _lerpValue * delta))


func set_value(newValue:int):
    value = newValue
    if text == null:
        text = $"Label"
    text.text = str(newValue)


func _on_pressed():
    _player.try_segment(self)
