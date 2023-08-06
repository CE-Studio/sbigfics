extends CharacterBody2D


const MOVE_SPEED = 300
const MIN_X = 0
const MAX_X = 675
const MIN_Y = 100
const MAX_Y = 492
var _startTimeout = 1.5
@onready var text = $"Label"


func _ready():
    velocity = Vector2(randf() * 8.0 - 4.0, 2.0).normalized()
    move_local_x(randf() * 1000.0 - 500.0)


func _process(delta):
    if _startTimeout < 0:
        if (position.x < MIN_X && velocity.x < 0) || (position.x > MAX_X && velocity.x > 0):
            velocity.x *= -1
        if (position.y < MIN_Y && velocity.y < 0) || (position.y > MAX_Y && velocity.y > 0):
            velocity.y *= -1
        position += MOVE_SPEED * delta * velocity
    else:
        _startTimeout -= delta
