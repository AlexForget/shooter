extends PathFollow2D

var player_near: bool = false

@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D

@onready var gun_fire1: Sprite2D = $Turret/RayCast2D/fire
@onready var gun_fire2: Sprite2D = $Turret/RayCast2D2/fire2

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio += 0.02 * delta
	if player_near:
		$Turret.look_at(Globals.player_position)
	#print($Turret/RayCast2D.get_collider())

func fire():
	Globals.health -= 20
	gun_fire1.modulate.a = 1
	gun_fire2.modulate.a = 1
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(gun_fire1, "modulate:a", 0, randf_range(0.1, 0.5))
	tween.tween_property(gun_fire2, "modulate:a", 0, randf_range(0.1, 0.5))

func _on_notice_area_body_entered(_body):
	player_near = true 
	$AnimationPlayer.play("LaserLoad")


func _on_notice_area_body_exited(_body):
	player_near = false 
	$AnimationPlayer.stop()

#test github
