extends Node3D
class_name Laptop

var _bbase:PackedScene = preload("res://assets/ip/ipbutton.tscn")
@onready var grid:GridContainer = $desktop/ScrollContainer/GridContainer
@onready var cur:Sprite2D = $TextureRect2
@onready var content:Node3D = $screentree
@onready var desk:Panel = $desktop
static var instance:Laptop


var counts := {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    instance = self
    for i in DirAccess.get_files_at("res://assets/CharacterIcons/"):
        var j = i.split(".")
        if j[-1] == "png":
            if j[0] == "Kevin 34":
                j[0] = "Kevin, 34"
            var tex = load("res://assets/CharacterIcons/" + i)
            var h:IPButton = _bbase.instantiate()
            h.ico = tex
            h.title = j[0]
            counts[j[0]] = randi_range(1, 300)
            h.count = counts[j[0]]
            h.cb = button

            grid.add_child(h)

    desk.visible = false
    content.add_child(load("res://games/gaps.tscn").instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func button(name:String):
    print(name)


func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        cur.position = event.position

func nextgame():
    for i in content.get_children():
        i.queue_free()
