extends FSM_State

func on_enter():
	if obj.question_text == "":
		fsm.state_next = fsm.states.Ready
	else:
		obj.reset_textbox()
		obj.textbox.show()
		obj.body.percent_visible = 0
		obj.body.text = obj.question_text
		obj.tween.interpolate_property(obj.body, "percent_visible", 0, 1.0, len(obj.body.text) * obj.READ_RATE, \
			obj.tween.TRANS_LINEAR, obj.tween.EASE_IN_OUT)
		obj.tween.start()

func on_exit():
	obj.ticker.hide()

func run(_delta):
	pass

func _input(event):
	if fsm.state_curr == fsm.states.QuestionText and Input.is_action_just_pressed("ui_accept") \
		and obj.tween.is_active():
			obj.tween.stop_all()
			obj.body.percent_visible = 1.0
			fsm.state_next = fsm.states.Selection
	elif Input.is_action_just_pressed("ui_accept") and fsm.state_curr == fsm.states.QuestionText:
			fsm.state_next = fsm.states.Selection

func _on_Tween_tween_completed(object, key):
	if fsm.state_curr == fsm.states.QuestionText:
		fsm.state_next = fsm.states.Selection
