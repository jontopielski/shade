extends Control

func _ready():
	$MenuOptions/NewGame.grab_focus()

func _on_NewGame_pressed():
	pass # Replace with function body.

func _on_Continue_pressed():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()
