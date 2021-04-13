extends CanvasLayer

var is_pause_active = false
var current_selection = 0

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
			current_selection = 0
			update_current_selection(current_selection)
			is_pause_active = true
			get_tree().paused = true
			$Menu.show()
	if (Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_right")) and is_pause_active:
		current_selection = min(total_menu_options - 1, current_selection + 1)
		update_current_selection(current_selection)
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left")) and is_pause_active:
		current_selection = max(0, current_selection - 1)
		update_current_selection(current_selection)
	if Input.is_action_just_pressed("ui_accept") and is_pause_active:
		match current_selection:
			0:
				get_tree().paused = false
				is_pause_active = false
				$Menu.hide()
			1:
				menu_options.get_node("Hint").pressed = true
			2:
				menu_options.get_node("Settings").pressed = true
			3:
				menu_options.get_node("Quit").pressed = true

func update_current_selection(_current_selection):
	for option in menu_options.get_children():
		option.pressed = false
	match _current_selection:
		0:
			menu_options.get_node("Resume").pressed = true
		1:
			menu_options.get_node("Hint").pressed = true
		2:
			menu_options.get_node("Settings").pressed = true
		3:
			menu_options.get_node("Quit").pressed = true
