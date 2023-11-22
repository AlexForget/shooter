extends CharacterBody2D

var speed = 300

func _ready():
	pass


func _process(_delta):
	var direction = Vector2.RIGHT
	velocity = direction * 400
	move_and_slide()

func hit():
	print("Damage")
