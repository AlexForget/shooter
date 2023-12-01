extends Node

signal stat_changed

var laser_amount: int = 20:
	set(value):
		laser_amount = value
		stat_changed.emit()


var grenade_amount: int = 5:
	set(value):
		grenade_amount = value
		stat_changed.emit()

var player_can_take_dommage: bool = true

var health: int = 60: 
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if player_can_take_dommage:
				health = value
				player_can_take_dommage = false
				player_can_take_dommage_timer()
		stat_changed.emit()

func player_can_take_dommage_timer():
	await get_tree().create_timer(0.5).timeout
	player_can_take_dommage = true

var player_position: Vector2
