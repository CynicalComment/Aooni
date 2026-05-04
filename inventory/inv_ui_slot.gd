extends Panel


@onready var item_visual: TextureRect = $CenterContainer/item_display
@onready var amount_text: Label = $CenterContainer/Label

func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture	
		if slot.amount > 1:
			amount_text.visible = true
		amount_text.text = str(slot.amount)
