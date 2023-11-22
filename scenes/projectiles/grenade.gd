extends RigidBody2D

const speed = 750

func explode():
	print("Big Boum!")
	$AnimationPlayer.play("Explosion")
