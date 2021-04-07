extends FSM_State

var can_proceed = false

func on_enter():
	if obj.initial_text == "":
		fsm.state_next = fsm.states.Ready
	else:
		can_proceed = false
		obj.textbox.show()
		obj.body.percent_visible = 0
		obj.body.text = obj.initial_text
		obj.tween.interpolate_property(obj.body, "percent_visible", 0, 1.0, len(obj.body.text) * obj.READ_RATE, \
			obj.tween.TRANS_LINEAR, obj.tween.EASE_IN_OUT)
		obj.tween.start()

func on_exit():
	obj.ticker.hide()

func run(_delta):
	pass

func _input(event):
	if fsm.state_curr == fsm.states.InitialText and Input.is_action_just_pressed("ui_accept") \
		and obj.tween.is_active() and !can_proceed and $Timer.is_stopped():
			obj.tween.stop_all()
			obj.body.percent_visible = 1.0
			$Timer.wait_time = obj.READ_RATE
			$Timer.start()
	elif Input.is_action_just_pressed("ui_accept") and can_proceed \
		and fsm.state_curr == fsm.states.InitialText:
			fsm.state_next = fsm.states.QuestionText

func _on_Tween_tween_completed(object, key):
	if fsm.state_curr == fsm.states.InitialText and !can_proceed and $Timer.is_stopped():
		$Timer.wait_time = obj.READ_RATE
		$Timer.start()

func _on_Timer_timeout():
	obj.ticker.show()
	can_proceed = true
