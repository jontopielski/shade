extends Button

func _on_MenuOptionArea_body_entered(body):
	if "Mouse" in body.name:
		pressed = true

func _on_MenuOptionArea_body_exited(body):
	if "Mouse" in body.name:
		pressed = false
