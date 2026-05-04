extends Node


enum MenuState {PLAYING, PAUSED, INVENTORY, DIALOGUE}

var current_state: MenuState = MenuState.PLAYING
var state_stack: Array = [] #fancy state history

func set_state(new_state: MenuState) -> bool:
	#NO INVENTORY IN PAUSE MENU
	if new_state == MenuState.INVENTORY and current_state == MenuState.PAUSED:
		print("inventory cant open!")
		return false
	state_stack.push_back(current_state) #new element and end of array :3
	current_state = new_state
	_apply_state()
	print("State changed to: ", MenuState.keys()[current_state])
	return true
	
func pop_state():
	if state_stack.is_empty():
		return
	current_state = state_stack.pop_back() #returns last array item and deletes it
	_apply_state()
	print("State popped to: ", MenuState.keys()[current_state])
	
func _apply_state():
	match current_state:
		MenuState.PLAYING:
			get_tree().paused = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		MenuState.PAUSED:
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		MenuState.INVENTORY:
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		MenuState.DIALOGUE:
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	print("Current state: ", GameState.MenuState.keys()[GameState.current_state])
	
