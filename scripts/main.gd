extends Node3D

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$UserInterface/MainMenu.show()
	GameState.set_state(GameState.MenuState.PAUSED)
	MusicPlayer.play_ambient()

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		if GameState.current_state == GameState.MenuState.PAUSED:
			GameState.pop_state()
			print("BE BETTER")
			$UserInterface/MainMenu.hide()
		else:
			GameState.set_state(GameState.MenuState.PAUSED)
			$UserInterface/MainMenu.show()
