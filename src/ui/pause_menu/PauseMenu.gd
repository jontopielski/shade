extends CanvasLayer

var is_pause_active = false

onready var menu_options = $Menu/Margin/MenuOptions
onready var total_menu_options = $Menu/Margin/MenuOptions.get_child_count()

func _ready():
	$Menu.hide()

func _input(event):
	if Input.is_action_just_pressed("ui_pause"):
		var is_tree_paused = get_tree().paused
		if is_tree_paused and !is_pause_active:
			return
		elif is_tree_paused and is_pause_active:
			get_tree().paused = false
			is_pause_active = false
			$Menu.hide()
		elif !is_tree_paused and !is_pause_active:
			$Menu/Margin/MenuOptions/Resume.grab_focus()
			is_pause_active = true
			get_tree().paused = true
			$Menu.show()

func _on_Quit_pressed():
	get_tree().quit()

func _on_Resume_pressed():
	get_tree().paused = false
	is_pause_active = false
	$Menu.hide()
