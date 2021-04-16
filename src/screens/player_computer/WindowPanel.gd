extends Control

signal focused(obj)

export(String) var title = ""

var is_hovering_header = false
var mouse_ref = null
var mouse_start_position = Vector2.ZERO
var is_following_mouse = false
var is_hovering_egg = false
var crack_count = 0

onready var viewport_size = get_viewport_rect().size

func _ready():
	$Panel.hide()
	$Cover.show()
	$Panel/Center/Title.text = title
	$Tween.start()

func set_window_params(_type, starting_position, ending_position):
	title = _type
	var tween_duration = 0.5
	var tween_type = $Tween.TRANS_QUAD
	$Tween.interpolate_property(self, "rect_scale", Vector2.ZERO, Vector2(1, 1), tween_duration, tween_type, Tween.EASE_IN_OUT)
	rect_position = starting_position
	$Tween.interpolate_property(self, "rect_position", rect_position, ending_position, tween_duration, tween_type, Tween.EASE_IN_OUT)
	match _type:
		"Game":
			$TrashObjects.queue_free()
			$Panel/Notes.hide()
			$Panel/Game.show()
			$Panel/Game/Egg/EggShadow.hide()
			$Panel/Game/Egg.show()
			$Panel/Game/EggPieces.hide()
			$Panel/Game/EggBlob.hide()
		"Trash":
			$TrashObjects.show()
			$Panel/Notes.hide()
			$Panel/Game.queue_free()
		"Notes":
			$TrashObjects.queue_free()
			$Panel/Notes.show()
			$Panel/Game.queue_free()


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		if $Panel/CloseArea/Sprite.frame == 1:
			queue_free()
		if is_hovering_header and mouse_ref:
			mouse_start_position = mouse_ref.position
			is_following_mouse = true
			emit_signal("focused", self)
		if is_hovering_egg and !$AnimationPlayer.is_playing():
			if crack_count < 3:
				$AnimationPlayer.play("egg_shake")
				crack_count += 1
				$Panel/Game/Egg.frame = crack_count
			elif crack_count == 3:
				crack_count += 1
				$Panel/Game/EggBlob.show()
				$Panel/Game/EggBlob.set_active()
				$AnimationPlayer.play("egg_shatter")
				$Panel/Game/Egg.hide()
	if Input.is_action_just_released("ui_accept"):
		mouse_start_position = Vector2.ZERO
		is_following_mouse = false

func _process(delta):
	if is_following_mouse:
		var position_change = mouse_ref.position - mouse_start_position
		mouse_start_position = mouse_ref.position
		rect_position += position_change
		rect_position.x = clamp(rect_position.x, 0, viewport_size.x - rect_size.x)
		rect_position.y = clamp(rect_position.y, 15, viewport_size.y - rect_size.y - 22)

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

func _on_EggArea_body_entered(body):
	if "Mouse" in body.name:
		is_hovering_egg = true
		$Panel/Game/Egg/EggShadow.show()

func _on_EggArea_body_exited(body):
	if "Mouse" in body.name:
		is_hovering_egg = false
		$Panel/Game/Egg/EggShadow.hide()
