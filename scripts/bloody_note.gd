extends Interactible

@export var item: InvItem
var player = null




func _on_interacted(body):
	player = body
	player.collect(item)
	queue_free()
