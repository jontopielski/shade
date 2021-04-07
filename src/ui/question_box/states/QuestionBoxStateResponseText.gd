extends FSM_State

func on_enter():
	obj.reset_textbox()
	obj.textbox.show()
	obj.body.percent_visible = 0
	obj.body.text = obj.yes_response if obj.option_selection == 0 else obj.no_response
	obj.tween.interpolate_property(obj.body, "percent_visible", 0, 1.0, len(obj.body.text) * obj.READ_RATE, \
		obj.tween.TRANS_LINEAR, obj.tween.EASE_IN_OUT)
	obj.tween.start()

func on_exit():
	pass

func run(_delta):
	pass

func _input(event):
	if fsm.state_curr == fsm.states.ResponseText and Input.is_action_just_pressed("ui_accept") \
		and obj.tween.is_active():
			obj.tween.stop_all()
			obj.body.percent_visible = 1.0
			fsm.state_next = fsm.states.Finished
	elif Input.is_action_just_pressed("ui_accept") and fsm.state_curr == fsm.states.ResponseText:
			fsm.state_next = fsm.states.Finished

func _on_Tween_tween_completed(object, key):
	if fsm.state_curr == fsm.states.ResponseText:
		fsm.state_next = fsm.states.Finished
