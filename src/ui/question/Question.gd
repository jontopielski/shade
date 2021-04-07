extends Node

export(Texture) var portrait = null
export(String) var speaker = ""
export(String) var initial_text = ""
export(String) var question = ""
export(String) var yes_response = ""
export(String) var no_response = ""

func ask():
	QuestionBox.set_portrait(portrait)
	QuestionBox.set_speaker(speaker)
	QuestionBox.set_question(initial_text, question, yes_response, no_response)
