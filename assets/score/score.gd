extends HBoxContainer
class_name Score


static var score:int = 0
var _scorestore:int = -1

var _digit:PackedScene = preload("res://assets/score/snumber.tscn")


func _process(delta: float) -> void:
    if _scorestore != score:
        _scorestore = score
        var scorestrting = str(_scorestore)
        for n in get_children():
            remove_child(n)
            n.queue_free()
        for i in scorestrting:
            var h:Control = _digit.instantiate()
            add_child(h)
            var j:AnimatedSprite2D = h.get_child(0)
            j.animation = i
