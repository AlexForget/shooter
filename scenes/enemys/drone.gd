extends CharacterBody2D

var speed = 300
var active: bool = false
var vulnerable: bool = true
var health: int = 50

func _ready():
	$Explosion.hide()

func _process(_delta):
	var direction = (Globals.player_position - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()
		look_at(Globals.player_position)

func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$HitTimer.start()
	if health <= 0:
		queue_free()


func _on_notice_area_body_entered(_body):
	active = true


func _on_hit_timer_timeout():
	vulnerable = true
