extends Game

const G := 0
const Y := 1
const R := 2
var signals:Array[Array] = [
    ["CLEAR", G, R, R],
    ["APPROACH MEDIUM", Y, G, R],
    ["MEDIUM CLEAR", R, G, R],
    ["MEDIUM APPROACH SLOW", R, Y, G],
    ["MEDIUM ADVANCE APPROACH", R, Y, Y],
    ["APPROACH SLOW", Y, R, G],
    ["APPROACH", Y, R, R],
    ["MEDIUM APPROACH", R, Y, R],
    ["SLOW CLEAR", R, R, G],
    ["SLOW APPROACH", R, R, Y],
]
var sel:Array
var opts:Array[String]
var pick:String
var going:bool = false
var unchecked:bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    signals.shuffle()
    sel = signals[0]
    opts = [signals[0][0], signals[1][0], signals[2][0]]
    opts.shuffle()
    $Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if going:
        $trein.position.x += (($trein.position.x + 500) / 1.5) * delta
        if ($trein.position.x > 100) and unchecked:
            unchecked = false
            if pick == sel[0]:
                $c.visible = true
                Game.score += 50
            else:
                $x.visible = true
                Game.score -= 20
        if ($trein.position.x > 1000):
            endgame()


func _on_timer_timeout() -> void:
    $s1.frame = sel[1]
    $s2.frame = sel[2]
    $s3.frame = sel[3]
    $TextureButton.visible = true
    $TextureButton2.visible = true
    $TextureButton3.visible = true
    $TextureButton/Label.text = opts[0]
    $TextureButton2/Label.text = opts[1]
    $TextureButton3/Label.text = opts[2]
    $AudioStreamPlayer.play()


func _on_texture_button_pressed() -> void:
    going = true
    pick = $TextureButton/Label.text
    $TextureButton.visible = false
    $TextureButton2.visible = false
    $TextureButton3.visible = false


func _on_texture_button_2_pressed() -> void:
    going = true
    pick = $TextureButton2/Label.text
    $TextureButton.visible = false
    $TextureButton2.visible = false
    $TextureButton3.visible = false


func _on_texture_button_3_pressed() -> void:
    going = true
    pick = $TextureButton3/Label.text
    $TextureButton.visible = false
    $TextureButton2.visible = false
    $TextureButton3.visible = false
