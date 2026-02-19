extends Control

@onready var inv: Inv = preload("res://inventory/PlayerInventory.tres")
@onready var slots: Array = $InventoryBackground/GridContainer.get_children()

var is_open = false

func _ready():
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.item.size(),slots.size())):
		slots[i].update(inv.item[i])

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false
	
