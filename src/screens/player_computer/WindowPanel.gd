extends Control

signal focused(obj)

export(String) var title = ""

var is_hovering_header = false
var mouse_ref = null
var mouse_start_position = Vector2.ZERO
var is_following_mouse = false

onready var viewport_size = get_viewport_rect().size

func _ready():
	$Panel.hide()
	$Cover.show()
	$Panel/Center/Title.text = title
	$Tween.start()

func set_window_type(_type):
	title = _type
	var tween_duration = 0.5
	var tween_type = $Tween.TRANS_QUAD
	$Tween.interpolate_property(self, "rect_scale", Vector2.ZERO, Vector2(1, 1), tween_duration, tween_type, Tween.EASE_IN_OUT)
	match _type:
		"Trash":
			rect_position = Vector2(28, 32)
			var final_position = Vector2(randi() % 40 + 60, randi() % 30 + 30)
			$Tween.interpolate_property(self, "rect_position", rect_position, final_position, tween_duration, tween_type, Tween.EASE_IN_OUT)
		"Notes":
			rect_position = Vector2(28, 86)
			var final_position = Vector2(randi() % 40 + 80, randi() % 30 + 65)
			$Tween.interpolate_property(self, "rect_position", rect_position, final_position, tween_duration, tween_type, Tween.EASE_IN_OUT)

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		if $Panel/CloseArea/Sprite.frame == 1:
			queue_free()
		if is_hovering_header and mouse_ref:
			mouse_start_position = mouse_ref.position
			is_following_mouse = true
			emit_signal("focused", self)
	if Input.is_action_just_released("ui_accept"):
		mouse_start_position = Vector2.ZERO
		is_following_mouse = false

func _process(delta):
	if is_following_mouse:
		var position_change = mouse_ref.position - mouse_start_position
		mouse_start_position = mouse_ref.position
		rect_position += position_change
		rect_position.x = clamp(rect_position.x, 0, viewport_size.x - rect_size.x)
		rect_position.y = clamp(rect_position.y, 15,	 viewport_size.y - rect_size.y - 22)

func _on_CloseArea_body_entered(body):
	if "Mouse" in body.name:
		$Panel/CloseArea/Sprite.frame = 1

func _on_CloseArea_body_exited(body):
	if "Mouse" in body.name:
		$Panel/CloseArea/Sprite.frame = 0

func _on_HeaderArea_body_entered(body):
	if "Mouse" in body.name:
		is_hovering_header = true
		mouse_ref = body

func _on_HeaderArea_body_exited(body):
	if "Mouse" in body.name:
		is_hovering_header = false
		is_following_mouse = false
		mouse_ref = null

func _on_Tween_tween_all_completed():
	$Cover.hide()
	$Panel.show()
