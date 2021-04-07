extends FSM_State

var can_proceed = false

func on_enter():
	can_proceed = false
	$Timer.wait_time = obj.READ_RATE
	$Timer.start()

func on_exit():
	obj.reset_textbox()

func run(_delta):
	pass

func _input(event):
	if fsm.state_curr == fsm.states.Finished and Input.is_action_just_pressed("ui_accept") \
		and can_proceed:
			obj.reset_question_box_state()
			fsm.state_next = fsm.states.Ready
			obj.emit_signal("finished")
			if obj.option_selection == 0:
				obj.emit_signal("yes_responded")
			else:
				obj.emit_signal("no_responded")

func _on_Timer_timeout():
	obj.ticker.show()
	can_proceed = true
