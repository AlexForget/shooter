extends PathFollow2D

var player_near: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio += 0.01 * delta
	if player_near:
		$Turret.look_at(Globals.player_position)


func _on_notice_area_body_entered(_body):
	player_near = true 


func _on_notice_area_body_exited(_body):
	player_near = false 