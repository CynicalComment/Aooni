extends Control

func _on_start_game_pressed():
	$MainMenu.hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_settings_pressed():
	pass # Replace with function body.


func _on_exit_game_pressed():
	get_tree().quit()
