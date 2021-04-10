extends CanvasLayer

var next_scene = null

func _ready():
	$ColorRect.material.set_shader_param("progress", 0.0)

func transition_to(next_scene_path):
	next_scene = load(next_scene_path)
	get_tree().paused = true
	$AnimationPlayer.play("fade_to_black")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		get_tree().change_scene_to(next_scene)
		$AnimationPlayer.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		get_tree().paused = false
