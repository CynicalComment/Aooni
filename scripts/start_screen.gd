extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenuButtons.position.y = -500
	$MainMenuButtons.modulate.a = 0.0  # fully transparent
	$MainMenuButtons/VBoxContainer.modulate.a = 0.0
	$AudioStreamPlayer3D.play()
	var tween = create_tween()
	
	tween.set_parallel\
	(true)
	tween.tween_property($MainMenuButtons, "position:y" , 400.0, .8)\
	.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property($MainMenuButtons, "modulate:a:" , 1.0, 0.6)
	tween.tween_property($MainMenuButtons/VBoxContainer, "modulate:a" , 1, 1.8)\
	.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_pressed():
	GameState.pop_state()
	var fade = create_tween()
	fade.tween_property(self, "modulate:a", 0,0.6)
	await fade.finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_settings_pressed():
	pass # Replace with function body.


func _on_exit_game_pressed():
	get_tree().quit()
