extends Node3D

func _ready():
	$UserInterface/MainMenu.show()
	$UserInterface/Retry.hide()
	get_tree().paused = true

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		#unpause game
		if get_tree().paused:
			get_tree().paused = false
			$UserInterface/MainMenu.hide()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		#pause game open menu
		elif ! get_tree().paused :
			get_tree().paused = true
			$UserInterface/MainMenu.show()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#Flip Flop inventory when game not paused
	#Potential Game Over
func _on_player_hit():
	$UserInterface/Retry.show()
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
