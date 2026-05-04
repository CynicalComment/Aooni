extends Control

@onready var inv: Inv = preload("res://inventory/PlayerInventory.tres")
@onready var slots: Array = $GridContainer.get_children()

var is_open = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	inv.update.connect(update_slots)
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.slots.size(),slots.size())):
		slots[i].update(inv.slots[i])

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()

func open():
	if not GameState.set_state(GameState.MenuState.INVENTORY):
		return	
	visible = true
	is_open = true
	$audio_inventory.play()
	self.position.y = -1000
	self.modulate.a = 0.0  # fully transparent
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position:y" , 320.0, 0.5)\
	.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "modulate:a", 1.0, 0.3)
	
func close():
	if GameState.current_state != GameState.MenuState.INVENTORY:
		return
	GameState.set_state(GameState.MenuState.PLAYING)
	$audio_inventoryClose.play()
	self.modulate.a = 1.0  # fully transparent
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position:y" , -500.0, 0.5)\
	.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "modulate:a", 0.0, 0.3)	
	await tween.finished
	visible = false
	is_open = false
