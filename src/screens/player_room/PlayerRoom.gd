extends Node2D

export(bool) var start_in_darkness = true
export(bool) var enable_palette = true

var is_in_light_area = false
var is_light_on = false

func _ready():
	if start_in_darkness:
		$Palette.set_color(Color.black)
	$Palette.is_enabled = enable_palette
	OS.set_window_title("Debug: Player Room")

func _on_Player_interacted(collider):
	if collider == $LightBulb/LightArea:
		if is_light_on:
			$Palette.set_color(Color.black)
			$LightBulb.frame = 0
			is_light_on = false
			$YSort/Plant.hide()
		else:
			$Palette.set_color(Constants.BLUE)
			$LightBulb.frame = 2
			is_light_on = true
			$YSort/Plant.show()