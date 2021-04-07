extends FSM_State

func on_enter():
	pass

func on_exit():
	pass

func run(_delta):
	if obj.question_text != "":
		fsm.state_next = fsm.states.InitialText
