extends AnimatableBody2D


const ORIGIN_Y := 512
const EXTENT := 350
const START_CENTER_BUFFER := 64
const ADVANCE_BUFFER := 0.05
const X_SPACE := 200
const SMEAR_START_X := 480
const SCORE_SCALE := 1.5

var _advanceTime := 0.25

@onready var _area:Area2D = $"Area2D"
@onready var _pillar2:AnimatableBody2D = $"../Pillar2"
@onready var _pillar3:AnimatableBody2D = $"../Pillar3"
@onready var _pillarParent:Node2D = $".."
@onready var _smear:Sprite2D = $"../../Smear"


# Called when the node enters the scene tree for the first time.
func _ready():
    position = Vector2(position.x, _get_rand_pos(true))
    _pillar2.position = Vector2(position.x + X_SPACE, _get_rand_pos(false))
    _pillar3.position = Vector2(position.x + X_SPACE * 2, _get_rand_pos(false))
    _smear.lerpY = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if _advanceTime > 0.0:
        _advanceTime -= delta
        if _advanceTime <= 0.0:
            _area.set_deferred("monitoring", true)
    
    
func _get_rand_pos(considerBuffer:bool) -> int:
    var output
    if (considerBuffer):
        output = randi_range(START_CENTER_BUFFER, EXTENT)
        output *= 1 if randf() > 0.5 else -1
    else:
        output = randi_range(-EXTENT, EXTENT)
    return ORIGIN_Y + output


func _on_area_2d_body_entered(body):
    if _advanceTime <= 0.0:
        _smear.position = Vector2(SMEAR_START_X, position.y)
        position = Vector2(position.x, _pillar2.position.y)
        _pillar2.position = Vector2(_pillar2.position.x, _pillar3.position.y)
        _pillar3.position = Vector2(_pillar3.position.x, _get_rand_pos(false))
        _area.set_deferred("monitoring", false)
        _advanceTime = ADVANCE_BUFFER
        _pillarParent.position += Vector2(X_SPACE, 0.0)
        Game.score += 5.0
        $"../../AudioStreamPlayer".play()
