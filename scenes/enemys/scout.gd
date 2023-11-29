extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var can_take_damage: bool = true
var right_gun_use: bool = true

var health: int = 30

signal laser(pos, direction)

func hit():
	if	can_take_damage:
		can_take_damage = false
		$Timer/HitTimer.start()
		health -= 10
		print(health)
		$Sprite2D.material.set_shader_parameter("progress", 1)
		$Timer/SaderTimer.start()
		
	if health <= 0:
		queue_free()

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_position)
		if can_laser:
			var marker_node = $LaserSpawnPosition.get_child(right_gun_use)
			right_gun_use = not right_gun_use
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_position - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timer/LaserCooldown.start()

func _on_attack_area_body_entered(_body):
	player_nearby = true

func _on_attack_area_body_exited(_body):
	player_nearby = false

func _on_laser_cooldown_timeout():
	can_laser = true

func _on_hit_timer_timeout():
	can_take_damage = true
	$Sprite2D.material.set_shader_parameter("progress", 0)

func _on_sader_timer_timeout():
	$Sprite2D.material.set_shader_parameter("progress", 0)
