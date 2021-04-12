extends Control

func _ready():
	$MenuOptions/NewGame.grab_focus()

func _on_NewGame_pressed():
	Transition.transition_to("res://src/screens/player_room/PlayerRoom.tscn")

func _on_Continue_pressed():
	Transition.transition_to("res://src/screens/player_room/PlayerRoom.tscn")

func _on_Quit_pressed():
	get_tree().quit()
