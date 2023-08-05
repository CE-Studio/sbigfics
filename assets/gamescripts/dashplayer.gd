extends CharacterBody2D
class_name DashPlayer


static var instance:DashPlayer


const GRAVITY := 5500.0
const JUMP_POWER := 1600.0
const ROT_LERP_SCALE := 15.0
const ROT_SPEED := 6.0
var _grounded := false
var _velocity := 0.0
var _isAlive := true
var _endTimer := 0.0
@onready var _startX := position.x
@onready var _spr := $"Sprite2D"
@onready var _level := $"../TileMap"
@onready var _explosion := $"../Explosion"
@onready var _exploSfx := $"../DeathSound"


# Called when the node enters the scene tree for the first time.
func _ready():
    instance = self
    _spr.rotation = round(_spr.rotation / PI * 0.5) * (PI * 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if (!_isAlive):
        return
    _grounded = is_on_floor()
    if _grounded:
        var divRot = _spr.rotation / (PI * 0.5)
        _spr.rotation = lerp(divRot, round(divRot), ROT_LERP_SCALE * delta) * (PI * 0.5)
        if Input.get_action_strength("MouseL") > 0.9:
            velocity = Vector2(velocity.x, -JUMP_POWER)
    else:
        _spr.rotate(ROT_SPEED * delta)
    velocity = Vector2(velocity.x, velocity.y + GRAVITY * delta)
    move_and_slide()
    if (position.x < _startX):
        _death()
    if _level.position.x < -19000.0:
        if !$"../AnimationPlayer".is_playing():
            $"../AnimationPlayer".play("DropComplete")
        _endTimer += delta
        if _endTimer > 1.5:
            Game.score += 200
            $"..".endgame()


func _on_enter_spike(body:Node2D):
    _death()


func _death():
    _isAlive = false
    _explosion.position = position
    _explosion.play("default")
    _exploSfx.play()
    Game.score += abs(_level.position.x) * 0.01 - 50
    $"../Music".stop()


func _on_death_sound_finished():
    $"..".endgame()
