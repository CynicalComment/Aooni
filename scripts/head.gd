extends Node3D

@onready var prompt = $InteractRay/Prompt
@export var sensitivity = .6

#WHOLE LOTTA INTERACT RAY
func _physics_process(delta):
	$InteractRay/Prompt.text = ""
	if $InteractRay.is_colliding() :
		var collider = $InteractRay.get_collider()
		if collider is Interactible:
			prompt.text = collider.get_prompt()
			
			if Input.is_action_just_pressed(collider.prompt_input):
				collider.interact(owner)
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		get_parent().rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
	
