extends FSM_State

var input = Vector2.ZERO

func on_enter():
	obj.particles.emission_sphere_radius = 3.5

func on_exit():
	pass

func run(_delta):
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if input == Vector2.ZERO:
		fsm.state_next = fsm.states.Idle
	else:
		input = input.normalized()
		obj.velocity = lerp(obj.velocity, input * obj.SPEED, obj.ACCELERATION * _delta)
		obj.move_and_slide(obj.velocity)
