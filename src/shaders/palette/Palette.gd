tool
extends CanvasLayer

export (bool) var is_enabled = true setget set_is_enabled
export(Color) var color = Color("306082") setget set_color

func _ready():
	set_shader_visible(is_enabled)

func set_color(_color):
	color = _color
	$Shader.material.set_shader_param("swap_color", color)

func set_is_enabled(_is_enabled):
	is_enabled = _is_enabled
	set_shader_visible(is_enabled)

func set_shader_visible(is_visible):
	$Shader.visible = is_visible
