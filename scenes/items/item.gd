extends Area2D

var rotation_speed: int = 2
var available_options = ["laser", "laser", "laser", "laser", "grenade", "health", "health"]
var type = available_options[randi()%len(available_options)]

func _ready():
	if type == "laser":
		$Sprite2D.modulate = Color(0.1,0.2,0.8)
	if type == "grenade":
		$Sprite2D.modulate = Color(0.8,0,2,0.1)
	if type == "health":
		$Sprite2D.modulate = Color(0.1,0.8,0.1)

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body):
	if type == "laser":
		Globals.laser_amount += 5
	if type == "grenade":
		Globals.grenade_amount += 1
	if type == "health":
		Globals.health += 10
	queue_free()
