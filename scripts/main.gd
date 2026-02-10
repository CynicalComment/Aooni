extends Node3D

func _ready():
	$UserInterface/MainMenu.show()
	$UserInterface/Retry.hide()
	get_tree().paused = true

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		#unpause game
		if get_tree().paused:
			print("YOUR FUCKING MOM")
			get_tree().paused = false
			$UserInterface/MainMenu.hide()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		#pause game open menu
		elif ! get_tree().paused :
			get_tree().paused = true
			print("O MY GOOOOD")
			$UserInterface/MainMenu.show()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.is_action_just_pressed("inventory") and not get_tree().paused:
		$UserInterface/Inventory.visible = ! $UserInterface/Inventory.visible
func _on_player_hit():
	$UserInterface/Retry.show()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()

func _on_exit_game_pressed():
	get_tree().quit()

func _on_start_game_pressed():
	$UserInterface/MainMenu.hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
