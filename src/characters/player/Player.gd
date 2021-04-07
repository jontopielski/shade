extends KinematicBody2D

signal interacted(collider)

const SPEED = 100.0

var velocity = Vector2()

func _ready():
	if !$AnimationTree.active:
		$AnimationTree.active = true
	TextBox.connect("finished", self, "_on_TextBox_finished")
	QuestionBox.connect("finished", self, "_on_QuestionBox_finished")

func _input(event):
	if Input.is_action_just_pressed("ui_accept") and $RayCast2D.enabled:
		var collider = $RayCast2D.get_collider()
		if collider:
			emit_signal("interacted", collider)
			if "StaticBody" in collider.name:
				if collider.get_parent().has_node("Dialog"):
					collider.get_parent().get_node("Dialog").begin()
					$RayCast2D.enabled = false
				elif collider.get_parent().has_node("Question"):
					collider.get_parent().get_node("Question").ask()
					$RayCast2D.enabled = false

func _physics_process(delta):
	velocity = Vector2.ZERO
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if velocity != Vector2.ZERO and can_move():
		$AnimationTree.set("parameters/Direction/blend_position", velocity)
		move_and_slide(velocity.normalized() * SPEED)

func can_move():
	return $RayCast2D.enabled

func _on_TextBox_finished():
	$RayCast2D.enabled = true

func _on_QuestionBox_finished():
	$RayCast2D.enabled = true
