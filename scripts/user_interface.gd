extends Control
@onready var stamina_bar = $HUD/StaminaBar


func _on_start_game_pressed():
	$MainMenu.hide()
	GameState.pop_state()


func _on_settings_pressed():
	pass # Replace with function body.


func _on_exit_game_pressed():
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
	
func set_stamina(value: float) -> void:
	stamina_bar.value = value * 100
