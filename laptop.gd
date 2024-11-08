extends Node3D
class_name Laptop

var _bbase:PackedScene = preload("res://assets/ip/ipbutton.tscn")
@onready var grid:GridContainer = $desktop/ScrollContainer/GridContainer
@onready var cur:Sprite2D = $TextureRect2
@onready var content:Node3D = $screentree
@onready var desk:Panel = $desktop
@onready var sleepscreen:Panel = $desktop2
static var instance:Laptop
static var awake := true


var counts := {}


var _tt := 0
var _typewait = false
var _games:Array[PackedScene]

var pick1 := ""
var pick2 := ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Arms.playc = 1
	Game.score = 0
	instance = self
	for i in DirAccess.get_files_at("res://assets/CharacterIcons/"):
		var j = i.split(".")
		if j[-1] == "import":
			var tex = load("res://assets/CharacterIcons/" + j[0] + ".png")
			if j[0] == "Kevin 34":
				j[0] = "Kevin, 34"
			var h:IPButton = _bbase.instantiate()
			h.ico = tex
			h.title = j[0]
			counts[j[0]] = randi_range(1, 300)
			h.count = counts[j[0]]
			h.cb = button

			grid.add_child(h)
	for i in DirAccess.get_files_at("res://games/"):
		var j = i.split(".")
		if (j[-1] == "tscn") or (j[-1] == "remap"):
			_games.append(load("res://games/" + j[0] + ".tscn"))


	#desk.visible = false
	#_loadgame()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _typewait and (Arms.playc <= 0):
		_typewait = false
		$Sprite2D.visible = false
		_loadgame()


func button(name:String):
	if pick1 == "":
		pick1 = name
		$AudioStreamPlayer.play()
	elif pick2 == "":
		pick2 = name
		$AudioStreamPlayer.play()
		_loadgame()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cur.position = event.position


func nextgame():
	Score.score = round(Game.score)
	for i in content.get_children():
		i.queue_free()
	Arms.playc = 5
	$Sprite2D.visible = true
	_typewait = true


func ticktype() -> void:
	_tt += 1
	$Sprite2D.frame = _tt % 3


func sleepytime():
	content.process_mode = Node.PROCESS_MODE_DISABLED
	desk.visible = false
	sleepscreen.visible = true
	awake = false


func caught():
	process_mode = Node.PROCESS_MODE_DISABLED


func win():
	caught()
	$"../../hall".process_mode = Node.PROCESS_MODE_DISABLED


func awaken():
	content.process_mode = Node.PROCESS_MODE_INHERIT
	desk.visible = true
	sleepscreen.visible = false
	awake = true


func _loadgame():
	content.add_child(_games.pick_random().instantiate())
	#content.add_child(load("res://games/towers.tscn").instantiate())
