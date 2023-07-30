extends TextureButton
class_name IPButton


@onready var _tex:TextureRect = $TextureRect
@onready var _lab:Label = $Label
@onready var _sub:Label = $Label2

static var _back = [preload("res://assets/ip/CompButton1.png"),
                    preload("res://assets/ip/CompButton2.png"),
                    preload("res://assets/ip/CompButton3.png")]

var ico:Texture2D
var title:String
var count:int
var cb:Callable


func _ready() -> void:
    _tex.texture = ico
    _lab.text = title
    _sub.text = "Stories: " + str(count)
    texture_normal = _back.pick_random()


func _on_pressed() -> void:
    cb.call(title)
