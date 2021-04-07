extends FSM_State

func on_enter():
	obj.option_selection = 0
	display_current_selection()
	$OptionsTimer.start()

func on_exit():
	pass

func run(_delta):
	pass

func _input(event):
	if fsm.state_curr == fsm.states.Selection and $OptionsTimer.is_stopped():
		if Input.is_action_just_pressed("ui_right"):
			obj.option_selection = 1 if obj.option_selection == 0 else 1
			display_current_selection()
		if Input.is_action_just_pressed("ui_left"):
			obj.option_selection = 0 if obj.option_selection == 1 else 0
			display_current_selection()
		if Input.is_action_just_pressed("ui_accept"):
			fsm.state_next = fsm.states.ResponseText

func display_current_selection():
	if obj.option_selection == 0:
		obj.selection_one_texture.show()
		obj.selection_two_texture.hide()
	elif obj.option_selection == 1:
		obj.selection_one_texture.hide()
		obj.selection_two_texture.show()

func _on_OptionsTimer_timeout():
	obj.options.show()
