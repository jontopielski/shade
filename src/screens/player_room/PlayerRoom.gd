extends Node2D

export(bool) var start_in_darkness = true
export(bool) var enable_palette = true

var is_in_light_area = false
var is_light_on = false

func _ready():
	if start_in_darkness:
		Palette.set_color(Color.black)
	else:
		Palette.set_color(Constants.BLUE)
	Palette.is_enabled = enable_palette

func _on_Player_interacted(collider):
	if collider == $LightBulb/LightArea:
		if is_light_on:
			Palette.set_color(Color.black)
			$LightBulb.frame = 0
			is_light_on = false
		else:
			Palette.set_color(Constants.BLUE)
			$LightBulb.frame = 2
			is_light_on = true

func _on_ComputerQuestion_yes_responded():
	Transition.transition_to("res://src/screens/player_computer/PlayerComputer.tscn")

func _on_ShelfQuestion_yes_responded():
	$AnimationPlayer.play("move_shelf")

func pause_game():
	get_tree().paused = true

func unpause_game():
	get_tree().paused = false

func _on_StairsArea_body_entered(body):
	Transition.transition_to("res://src/screens/stairwell/Stairwell.tscn")
