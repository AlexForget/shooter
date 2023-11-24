extends LevelParent

#var inside_level_scene: PackedScene = preload("res://scenes/levels/inside.tscn")

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.4)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")
#	get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")
#	get_tree().change_scene_to_packed(inside_level_scene)


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.4, 0.4), 2)
