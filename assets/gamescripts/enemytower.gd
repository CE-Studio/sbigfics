extends RigidBody2D


var value := 0
@onready var _text := $"Label"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func set_value(newValue:int):
    value = newValue
    if _text == null:
        _text = $"Label"
    _text.text = str(newValue)
