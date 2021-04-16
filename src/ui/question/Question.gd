extends Node

signal yes_responded()
signal no_responded()

export(Texture) var portrait = null
export(String) var speaker = ""
export(String) var initial_text = ""
export(String) var question = ""
export(String) var yes_response = ""
export(String) var no_response = ""

var is_question_active = false

func _ready():
	QuestionBox.connect("yes_responded", self, "_on_QuestionBox_yes_responded")
	QuestionBox.connect("no_responded", self, "_on_QuestionBox_no_responded")
	QuestionBox.connect("finished", self, "_on_QuestionBox_finished")

func ask():
	is_question_active = true
	QuestionBox.set_portrait(portrait)
	QuestionBox.set_speaker(speaker)
	QuestionBox.set_question(initial_text, question, yes_response, no_response)

func _on_QuestionBox_yes_responded():
	if is_question_active:
		emit_signal("yes_responded")

func _on_QuestionBox_no_responded():
	if is_question_active:
		emit_signal("no_responded")

func _on_QuestionBox_finished():
	$FinishedDelayTimer.start()

func _on_FinishedDelayTimer_timeout():
	is_question_active = false
