extends Control

const START_TEXTURE_NORMAL = preload("res://sprites/screens/player_computer/start_button/StartNormal.png")
const START_TEXTURE_HOVER = preload("res://sprites/screens/player_computer/start_button/StartHover.png")
const WindowPanel = preload("res://src/screens/player_computer/WindowPanel.tscn")

onready var time = $Taskbar/Time/Center/HBox/Time
onready var am_pm = $Taskbar/Time/Center/HBox/AmPm

var current_second = 0
var is_hovering_start_button = false
var is_hovering_over_desktop = false

func _ready():
#	if $Palette:
#		$Palette.set_color(Constants.WINDOWS)
	$StartMenu.hide()
	var date_time = OS.get_datetime()
	current_second = date_time.second
	$ClockTimer.start()
	set_time(date_time)
	OS.set_window_title("Debug: Player Computer")

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		if is_hovering_start_button:
			$Taskbar/StartButton.pressed = !$Taskbar/StartButton.pressed
			if $Taskbar/StartButton.pressed:
				$StartMenu.show()
			else:
				$StartMenu.hide()
		if is_hovering_over_desktop and $Taskbar/StartButton.pressed:
			$Taskbar/StartButton.pressed = false
			$StartMenu.hide()
		if $NotesIcon/NotesButton.pressed and !is_window_open("notes"):
			open_notes_window()
		if $TrashIcon/TrashButton.pressed and !is_window_open("trash"):
			open_trash_window()
		if $Taskbar/StartButton.pressed:
			for option in $StartMenu/MenuOptions.get_children():
				if "Option" in option.name:
					if option.pressed:
						match option.name:
							"GameOption":
								pass
							"TrashOption":
								if !is_window_open("trash"):
									open_trash_window()
									$StartMenu.hide()
									$Taskbar/StartButton.pressed = false
							"NotesOption":
								if !is_window_open("notes"):
									open_notes_window()
									$StartMenu.hide()
									$Taskbar/StartButton.pressed = false
							"QuitOption":
								Transition.transition_to("res://src/screens/player_room/PlayerRoom.tscn")

func open_trash_window():
	var next_window = WindowPanel.instance()
	next_window.set_window_type("Trash")
	$Windows.add_child(next_window)
	next_window.connect("focused", self, "_on_WindowPanel_focused")

func open_notes_window():
	var next_window = WindowPanel.instance()
	next_window.set_window_type("Notes")
	$Windows.add_child(next_window)
	next_window.connect("focused", self, "_on_WindowPanel_focused")

func _on_WindowPanel_focused(obj):
	for child in $Windows.get_children():
		child.show_behind_parent = obj != child

func is_window_open(title):
	for window in $Windows.get_children():
		if window.title.to_lower() == title.to_lower():
			return true
	return false

func set_time(date_info):
	var _am_pm = "AM" if date_info.hour <= 11 else "PM"
	var date_hour = date_info.hour if date_info.hour <= 12 else date_info.hour - 12
	time.text = "%02d:%02d" % [date_hour, date_info.minute]
	am_pm.text = _am_pm

func set_icon():
	var icon = Image.new()
	icon.load("res://sprites/screens/player_computer/TrashIcon.png")
	OS.set_icon(icon)

func _on_ClockTimer_timeout():
	current_second += 1
	if current_second == 60:
		current_second = 0
		set_time(OS.get_datetime())

func _on_StartButton_pressed():
	$StartMenu.visible = !$StartMenu.visible

func _on_StartButtonArea_body_entered(body):
	if "Mouse" in body.name:
		is_hovering_start_button = true
		$Taskbar/StartButton.texture_normal = START_TEXTURE_HOVER

func _on_StartButtonArea_body_exited(body):
	if "Mouse" in body.name:
		is_hovering_start_button = false
		$Taskbar/StartButton.texture_normal = START_TEXTURE_NORMAL

func _on_DesktopArea_body_entered(body):
	if "Mouse" in body.name:
		is_hovering_over_desktop = true

func _on_DesktopArea_body_exited(body):
	if "Mouse" in body.name:
		is_hovering_over_desktop = false

func _on_TrashIconArea_body_entered(body):
	if "Mouse" in body.name:
		$TrashIcon/TrashButton.pressed = true
		$TrashIcon/Shadow.show()

func _on_TrashIconArea_body_exited(body):
	if "Mouse" in body.name:
		$TrashIcon/TrashButton.pressed = false
		$TrashIcon/Shadow.hide()

func _on_NotesIconArea_body_entered(body):
	if "Mouse" in body.name:
		$NotesIcon/NotesButton.pressed = true
		$NotesIcon/Shadow.show()

func _on_NotesIconArea_body_exited(body):
	if "Mouse" in body.name:
		$NotesIcon/NotesButton.pressed = false
		$NotesIcon/Shadow.hide()
