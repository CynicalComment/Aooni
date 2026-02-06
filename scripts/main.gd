extends Node3D

func _ready():
	$UserInterface/Retry.hide()


func _on_player_hit():
	$UserInterface/Retry.show()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
