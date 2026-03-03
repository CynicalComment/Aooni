extends Node3D



func toggle(body):
	$LightBulb.visible = ! $LightBulb.visible


func _on_button_interacted(body):
	$LightBulb.visible = ! $LightBulb.visible
