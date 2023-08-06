extends VBoxContainer
class_name Textbox

static var instance:Textbox
@export var sounds:Dictionary
var _tosay:Array[String] = [""]
var _i := 0
var _phase := true
var _phases := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    $PanelContainer2/Label.text = ""
    instance = self


func _talk():
    if Hall.sel.name != "seanna ruby":
        $AudioStreamPlayer.stream = sounds[Hall.sel.name]
        $PanelContainer2/Label.text += _tosay[0][_i]
        _i += 1
        if _i < _tosay[0].length():
            $Timer.start()
            $AudioStreamPlayer.play()
        else:
            $"../Panel/AnimationPlayer".play("lose")
    else:
        if _phase:
            if _phases == false:
                $AudioStreamPlayer.stream = sounds["seanna"]
                _phases = true
            $PanelContainer2/Label.text += _tosay[0][_i]
            _i += 1
            if _i < _tosay[0].length():
                $Timer.start()
                $AudioStreamPlayer.play()
            else:
                _phase = false
                $PanelContainer2/Label.text += "\n"
                $Timer.start()
                _i = 0
                $AudioStreamPlayer.stream = sounds["ruby"]
                Hall.sel.play("talk1")
        else:
            $PanelContainer2/Label.text += _tosay[1][_i]
            _i += 1
            if _i < _tosay[1].length():
                $Timer.start()
                $AudioStreamPlayer.play()
            else:
                $"../Panel/AnimationPlayer".play("lose")



func speak():
    visible = true
    if Hall.sel.name == "fyrf":
        $PanelContainer/Label.text = "Fuck... Dad caught me!"
        $PanelContainer2/Label.text = "Fyrf: \"...?\" *Curious head tilt*"
        $"../Panel/AnimationPlayer".play("lose")
        return
    elif Hall.sel.name == "gamma":
        $PanelContainer/Label.text = "Fuck... Mom caught me!"
        _tosay = ["Gamma: \"Oh, sorry, hun; didn't mean to walk in on you!\""]
        _talk()
    elif Hall.sel.name == "fletch":
        $PanelContainer/Label.text = "Fuck... My brother caught me!"
        _tosay = ["Fletch: \"Aaah, back at *that* again, are we?\""]
        _talk()
    elif Hall.sel.name == "rho":
        $PanelContainer/Label.text = "Fuck... My sister caught me!"
        _tosay = ["Rho: \"Ah. Who’s it about this time?\""]
        _talk()
    elif Hall.sel.name == "sarah":
        $PanelContainer/Label.text = "Fuck... My sister caught me!"
        _tosay = ["Sarah: \"Yep, thought so~!\""]
        _talk()
    elif Hall.sel.name == "seanna ruby":
        $PanelContainer/Label.text = "Fuck... My sisters caught me!"
        _tosay = ["Seanna: \"Ooh, this again? Heh, sorry!\"", "Ruby: \"So sorry!\""]
        _talk()
    Hall.sel.play("talk")


func _on_button_pressed() -> void:
    get_tree().reload_current_scene()


func _on_overalltime_timeout() -> void:
    Laptop.instance.win()
    var h = [Laptop.instance.pick1, Laptop.instance.pick2]
    h.sort()
    var j = min(Laptop.instance.counts[h[0]], Laptop.instance.counts[h[1]])
    $"../Panel/Control/Sprite2D/Label".text = "<3 <3 " + h[0] + " x " + h[1] + " <3 <3"
    $"../Panel/Control/Sprite2D/Label2".text = str(round(Game.score))
    $"../Panel/Control/Sprite2D/Label3".text = str(round(Game.score * (301 - j)))
    if ResourceLoader.exists("res://assets/cover/" + h[0] + " x " + h[1] + ".svg"):
        $"../Panel/Control/Sprite2D/Sprite2D".texture = load("res://assets/cover/" + h[0] + " x " + h[1] + ".svg")
    $"../Panel/AnimationPlayer".play("win")
