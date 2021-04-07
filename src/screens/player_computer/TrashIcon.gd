extends Node2D

const SPEED = 2.0

func _physics_process(delta):
	for slice in $Slices.get_children():
		slice.rotate(SPEED * delta)
