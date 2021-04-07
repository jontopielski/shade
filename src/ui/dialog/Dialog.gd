extends Node

export(Texture) var portrait = null
export(String) var speaker = ""
export(String) var dialog = ""

func begin():
	TextBox.set_portrait(portrait)
	TextBox.set_speaker(speaker)
	TextBox.push_text(dialog)
