extends Node2D


var _origin := position
var timescale := 10.0
var lerpX := true
var lerpY := true


# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var newX = lerp(position.x, _origin.x, timescale * delta) if lerpX else position.x
    var newY = lerp(position.y, _origin.y, timescale * delta) if lerpY else position.y
    position = Vector2(newX, newY)
