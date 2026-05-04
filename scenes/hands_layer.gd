extends CanvasLayer

@export var drag_amount: float = 30.0
@export var drag_speed: float = 6.0

var current_offset: Vector2 = Vector2.ZERO
var last_camera_rotation: Vector3

@onready var hand: TextureRect = $Control/TextureRect
@onready var camera: Camera3D = $"../Camera3D"# assign in inspector

func _ready():
	last_camera_rotation = camera.global_rotation

func _process(delta):
	var rotation_delta = camera.global_rotation - last_camera_rotation
	last_camera_rotation = camera.global_rotation

	var target_offset = Vector2(
		-rotation_delta.y * drag_amount * 100,
		rotation_delta.x * drag_amount * 100
	)

	current_offset = current_offset.lerp(target_offset, drag_speed * delta)

	# Nudge the offsets from wherever the anchor is sitting
	hand.offset_left = current_offset.x
	hand.offset_right = current_offset.x
	hand.offset_top = current_offset.y
	hand.offset_bottom = current_offset.y
