extends CharacterBody2D

var max_speed: int = 600
var speed: int = 0
var speed_multiplier: int = 1
var active: bool = false
var vulnerable: bool = true
var health: int = 50
var explosion_active: bool = false
var explosion_radius: int = 400

func _ready():
	$Explosion.hide()
	visible = true

func _process(delta):
	var direction = (Globals.player_position - position).normalized()
	velocity = direction * speed * speed_multiplier
	if active:
		look_at(Globals.player_position)
		var collision = move_and_collide(velocity * delta)
		if collision:
			$Explosion/AnimationPlayer.play("explosion")
			explosion_active = true
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
				target.hit()

func stop_movement():
	$CollisionShape2D.disabled = true
	speed_multiplier = 0

func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$DroneImage.material.set_shader_parameter("progress", 0.7)
		$HitTimer.start()
	if health <= 0:
		$Explosion/AnimationPlayer.play("explosion")
		explosion_active = true


func _on_notice_area_body_entered(_body):
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)


func _on_hit_timer_timeout():
	vulnerable = true
	$DroneImage.material.set_shader_parameter("progress", 0.0)
