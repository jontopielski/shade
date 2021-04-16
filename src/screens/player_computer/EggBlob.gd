extends Node2D

var is_active = false
var is_hovering = false

func set_active():
	$Area2D/CollisionShape2D.disabled = false
	is_active = true
	$TeethTimer.start()
	$Teeth.show()

func _input(event):
	if Input.is_action_just_pressed("ui_accept") and is_hovering \
		and is_active and $TeethTimer.is_stopped():
			$TeethTimer.start()
			$Teeth.show()

func _on_Area2D_body_entered(body):
	if is_active and "Mouse" in body.name:
		is_hovering = true
		$Shadow.show()

func _on_Area2D_body_exited(body):
	if is_active and "Mouse" in body.name:
		is_hovering = false
		$Shadow.hide()

func _on_TeethTimer_timeout():
	$Teeth.hide()
