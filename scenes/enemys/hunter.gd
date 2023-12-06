extends CharacterBody2D

var active: bool = false


func _process(delta):
	move_and_slide()



func _on_notice_area_body_entered(_body):
	active = true
	print(active)


func _on_notice_area_body_exited(_body):
	active = false
	print(active)
