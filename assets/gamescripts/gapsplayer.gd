extends CharacterBody2D


var _vel := 0.0
var _lastSign := 0
var _lerpPoint := 0.0
const MAX_VEL := 400.0
const ACCEL := 750.0
const OFFSET := 110
const BOUNDS := 45.0
const SCORE_SCALE := 0.0025
const ROT_MULT := 0.0025
const FIELD_SIZE := 804
const TURNAROUND := 2.5


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var scoreMult = Game.score * SCORE_SCALE + 1.0
    _lerpPoint = inverse_lerp(-MAX_VEL, MAX_VEL, _vel)
    if _vel != 0.0:
        _lastSign = 1 if _vel > 0.0 else -1
    else:
        _lastSign = 0
    if Input.get_action_strength("MouseR") > 0.9:
        _vel += ACCEL * delta * lerpf(TURNAROUND, 1, _lerpPoint) * scoreMult
    elif Input.get_action_strength("MouseL") > 0.9:
        _vel -= ACCEL * delta * lerpf(1, TURNAROUND, _lerpPoint) * scoreMult
    else:
        _vel -= ACCEL * delta * _lastSign * scoreMult
        if ((_vel > 0.0 && _lastSign == -1) || (_vel < 0.0 && _lastSign == 1)):
            _vel = 0.0
            _lastSign = 0
    _vel = clampf(_vel, -MAX_VEL * scoreMult, MAX_VEL * scoreMult)
    velocity = Vector2(0, _vel)
    move_and_slide()
    position = Vector2(position.x, OFFSET + clampf(position.y - OFFSET, BOUNDS, FIELD_SIZE - BOUNDS))
    rotation = clamp(_vel * ROT_MULT, -PI * 0.5, PI * 0.5)
