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


var health: int = 60: 
	set(value):
		health = value
		if health > 100:
			health = 100
		stat_changed.emit()


