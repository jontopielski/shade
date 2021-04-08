extends FSM_State

var can_proceed = false

func on_enter():
	can_proceed = false
	$Timer.wait_time = obj.READ_RATE
	$Timer.start()

func on_exit():
	pass

func run(_delta):
	pass

func _input(event):
	if fsm.state_curr == fsm.states.Finished and Input.is_action_just_pressed("ui_accept") \
		and can_proceed:
			var selected_option = obj.option_selection
			obj.reset_textbox()
			obj.reset_question_box_state()
			fsm.state_next = fsm.states.Ready
			obj.emit_signal("finished")
			if selected_option == 0:
				obj.emit_signal("yes_responded")
			else:
				obj.emit_signal("no_responded")
			

func _on_Timer_timeout():
	obj.ticker.show()
	can_proceed = true
