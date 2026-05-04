extends Interactible

#QUICKY INVENTORY
@export var item: InvItem
@export var door_speed = 1
@export var open_angle = 90
@export var locked = false
@onready var audio_close = $audio_close
@onready var audio_open = $audio_open
@onready var door_pivot = $DoorPivot

var is_open = false
var tween : Tween
var player = null

func _on_interacted(body):
	player = body
	#if InventoryManger.inventory.slots.has(BloodyNote.tres):
	if is_open:
		close_door()
	else:
		open_door()
	
func open_door():
	is_open = true
	audio_open.play()
	animate_door(deg_to_rad(open_angle))

func close_door():
	is_open = false
	audio_close.play()
	animate_door(deg_to_rad(0))
	
func animate_door(target_angle: float):
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "rotation:y", target_angle, door_speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
