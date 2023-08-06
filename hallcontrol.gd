extends Node3D


@onready var chars:Array = get_children()
@export var caughtpos := Vector3.ZERO
@export var caughtrot := Vector3.ZERO
@export var doorclosed := false
var uncaught := true

static var sel:AnimatedSprite3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func send():
    if uncaught:
        sel = chars.pick_random()
        sel.flip_h = !sel.flip_h
        $"../halltime".wait_time = randf_range(10, 40)
        $"../halltime".start()
        $"../halldoorsound".play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if uncaught:
        for i in chars:
            if i.flip_h:
                i.position.x = clampf(i.position.x + (5 * delta), -20, 20)
            else:
                i.position.x = clampf(i.position.x - (5 * delta), -20, 20)
        if sel != null:
            if sel.name != "rhare":
                if (sel.position.x > -3) && (sel.position.x < 2):
                    if !doorclosed && Laptop.awake:
                        uncaught = false
                        sel.flip_h = true
                        Laptop.instance.caught()
                        $"../overalltime".stop()
                        $"../armanims".play("caught")
                        $"../laptopgame/Cube_001/StaticBody3D".input_ray_pickable = false
                        $"../laptopgame/Cube_001/StaticBody3D2".input_ray_pickable = false
                        $"../StaticBody3D".input_ray_pickable = false
                        $"../cur".visible = false
    else:
        sel.position.x = caughtpos.x
        sel.position.z = caughtpos.z
        sel.rotation = caughtrot
