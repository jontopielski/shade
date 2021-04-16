tool
extends Node2D

const SPEED = 2.0

enum Layout { HORIZONTAL, VERTICAL }

export(Texture) var sprite_sheet = null setget set_sprite_sheet
export(Layout) var layout = Layout.HORIZONTAL setget set_layout
export(int) var frames = 0 setget set_frames

func set_sprite_sheet(_sprite_sheet):
	sprite_sheet = _sprite_sheet
	draw_sprite()

func set_layout(_layout):
	layout = _layout
	draw_sprite()

func set_frames(_frames):
	frames = _frames
	draw_sprite()

func _ready():
	draw_sprite()

func _physics_process(delta):
	if has_node("Slices"):
		for slice in $Slices.get_children():
			slice.rotate(SPEED * delta)

func draw_sprite():
	if has_node("Slices"):
		for child in $Slices.get_children():
			child.queue_free()
		for i in range(0, frames):
			var next_sprite = Sprite.new()
			next_sprite.texture = sprite_sheet
			next_sprite.hframes = frames if layout == Layout.HORIZONTAL else 1
			next_sprite.vframes = frames if layout == Layout.VERTICAL else 1
			next_sprite.frame = i
			next_sprite.position.y = -i
			$Slices.add_child(next_sprite)
