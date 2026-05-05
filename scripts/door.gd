extends Interactible

#QUICKY INVENTORY
@export var item: InvItem
@export var door_speed = 1
@export var open_angle = 90
@export var starts_locked = false
@onready var audio_close = $audio_close
@onready var audio_open = $audio_open
@onready var door_pivot = $DoorPivot
@onready var audio_locked = $audio_locked
@onready var inv: Inv = preload("res://inventory/PlayerInventory.tres")

var locked = false
var is_open = false
var tween : Tween
var player = null

func _ready():
	locked = starts_locked
	get_prompt()
func _on_interacted(body):
	player = body
	if locked:
		prompt_message = "Unlock"
		print(locked)
		if inv.has_item("res://inventory/items/BloodyNote.tres"):
			locked = false
			print(locked)
		else:
			animate_door(deg_to_rad(5))
			audio_locked.play()
	if not locked:
		if is_open:
			close_door()
		else:
			open_door()
	
func open_door():
	prompt_message = "Close"
	is_open = true
	audio_open.play()
	animate_door(deg_to_rad(open_angle))

func close_door():
	prompt_message = "Open"
	is_open = false
	audio_close.play()
	animate_door(deg_to_rad(0))
	
func animate_door(target_angle: float):
	if tween:
		tween.kill()
	tween = create_tween()
	if not locked:
		tween.tween_property(self, "rotation:y", target_angle, door_speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	if locked:
		tween.tween_property(self, "rotation:y", target_angle, .3)\
		.set_trans(Tween.TRANS_BOUNCE)\
		.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y", -1 * target_angle, .3)\
		.set_trans(Tween.TRANS_BOUNCE)\
		.set_ease(Tween.EASE_OUT)
