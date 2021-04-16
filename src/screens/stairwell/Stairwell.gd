extends Node2D

const DARK_COLOR = Color("323c39")
const MEDIUM_COLOR = Color("323c39")
const LIGHT_COLOR = Color("323c39")

func _ready():
	Palette.set_color(LIGHT_COLOR)

var has_removed_stairs = false
func _on_StairsNotifier_screen_exited():
	if !has_removed_stairs:
		$TileMap.queue_free()
		$Lines.queue_free()
		$DarknessTimer.start()
		has_removed_stairs = true

func _on_DarknessTimer_timeout():
	Palette.set_color(Color.black)
