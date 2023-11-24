extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

signal laser_is_use(pos, direction)
signal grenade_is_use(pos, direction)

@export var max_speed: int = 500
var speed: int = max_speed



func _process(_delta):
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	# rotate the player
	look_at(get_global_mouse_position())
	
	var player_direction = (get_global_mouse_position() - position).normalized()
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		can_laser = false
		$LaserTimer.start()
		# randomly select a marker 2D for the laser
		var laser_markers = $LaserStartPosition.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		$GPUParticles2D.emitting = true
		# emit the position selected
		laser_is_use.emit(selected_laser.global_position, player_direction)
	
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$GrenadeTimer.start()
		var grenade_markers = $GrenadeStartPosition.get_children()
		var selected_grenade = grenade_markers[randi() % grenade_markers.size()]
		grenade_is_use.emit(selected_grenade.global_position, player_direction)


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
