extends FSM_State

func on_enter():
	obj.particles.emission_sphere_radius = 2.0

func on_exit():
	pass

func run(_delta):
	obj.velocity = lerp(obj.velocity, Vector2.ZERO, obj.ACCELERATION * _delta)
	obj.move_and_slide(obj.velocity)
	if Helpers.IsMoving():
		fsm.state_next = fsm.states.Move
