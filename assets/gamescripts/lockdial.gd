extends Sprite2D


const ROT_SPEED := 6.0
const SCALE_SPEED := 5.0
const MIN_ZOOM_SCALE := 0.75
const MAX_ZOOM_SCALE := 1.333
const MIN_LEVELS := 4
const MAX_LEVELS := 9
const MAX_ROTATION := 2.85
const ROT_MATCH_BUFFER: = 0.15
const ROT_RANDO_BUFFER: = 0.4
const SCORE_SCALE := 0.15
const SCORE_OFFSET := 30
const ARC_TARGET_Y := 256.0
var _currentLevel := 1
var _maxLevels := MIN_LEVELS
var _subdials := []
var gaming := true
var _mainScale := 1.0
var _outerScale := MAX_ZOOM_SCALE
@onready var _outerdial := $"../LargerDial"
@onready var _stopper := $"../Stopper"
@onready var _arc := $"../Arc"


# Called when the node enters the scene tree for the first time.
func _ready():
    _subdials.append($"SubDial1")
    _subdials.append($"SubDial1/SubDial2")
    _subdials.append($"SubDial1/SubDial2/SubDial3")
    _subdials.append($"SubDial1/SubDial2/SubDial3/SubDial4")
    _subdials.append($"SubDial1/SubDial2/SubDial3/SubDial4/SubDial5")
    _subdials.append($"SubDial1/SubDial2/SubDial3/SubDial4/SubDial5/SubDial6")
    _subdials.append($"SubDial1/SubDial2/SubDial3/SubDial4/SubDial5/SubDial6/SubDial7")
    _subdials.append($"SubDial1/SubDial2/SubDial3/SubDial4/SubDial5/SubDial6/SubDial7/SubDial8")
    for i in _subdials.size():
        _subdials[i].set_deferred("visible", false)
    _randomize_outer_dial()
    _maxLevels = clampi((Game.score - SCORE_OFFSET) * SCORE_SCALE, MIN_LEVELS, MAX_LEVELS)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if gaming:
        if Input.get_action_strength("MouseL") > 0.9:
            rotation -= ROT_SPEED * delta
        elif Input.get_action_strength("MouseR") > 0.9:
            rotation += ROT_SPEED * delta
        rotation = clamp(rotation, -MAX_ROTATION, MAX_ROTATION)
        _mainScale = lerp(_mainScale, 1.0, SCALE_SPEED * delta)
    else:
        _mainScale = lerp(_mainScale, MIN_ZOOM_SCALE, SCALE_SPEED * delta)
        _outerScale = lerp(_outerScale, 1.0, SCALE_SPEED * delta)
        _arc.position = Vector2(512, lerp(_arc.position.y, ARC_TARGET_Y, SCALE_SPEED * delta))
    scale = Vector2(_mainScale, _mainScale)
    _outerdial.scale = Vector2(_outerScale, _outerScale)
    if absf(rotation - _outerdial.rotation) < ROT_MATCH_BUFFER && gaming:
        _advance_level()
        
        
func _randomize_outer_dial() -> void:
    _outerdial.scale = Vector2(_outerScale, _outerScale)
    while absf(rotation - _outerdial.rotation) < ROT_RANDO_BUFFER:
        _outerdial.rotation = randf_range(-MAX_ROTATION, MAX_ROTATION)
    
    
func _advance_level():
    rotation = _outerdial.rotation
    _currentLevel += 1
    if _currentLevel == _maxLevels:
        gaming = false
        _stopper.reparent(self)
        _mainScale = 1.0
        Game.score += 15
        $"../WinAudio".play()
    else:
        _mainScale = MAX_ZOOM_SCALE
        _randomize_outer_dial()
        _subdials[_currentLevel - 2].set_deferred("visible", true)
        $"../AdvanceAudio".play()
