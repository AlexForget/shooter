extends CharacterBody2D

var active: bool = false
var speed: int = 200

func _ready():
	$NavigationAgent2D.target_position = Globals.player_position
	

	

func _physics_process(_delta):
	if active:
		await get_tree().process_frame
		var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		look_at(Globals.player_position)

func _on_notice_area_body_entered(_body):
	active = true
	print(active)


func _on_notice_area_body_exited(_body):
	active = false
	print(active)


func _on_navigation_timer_timeout():
	if active:
		$NavigationAgent2D.target_position = Globals.player_position
