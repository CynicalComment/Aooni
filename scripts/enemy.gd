extends CharacterBody3D


var player = null
var encounter = false
@export var chase_timer_MAX = 10 #actual timer length

const SPEED = 3.0

@export var player_path : NodePath
@onready var nav_agent = $NavigationAgent3D
@onready var shape_cast = $ShapeCast3D
var chase_timer : float = 0.0 #countdown value for timer

func _ready() -> void:
	player = get_node(player_path)
func _physics_process(delta):
	velocity = Vector3.ZERO
	if $ShapeCast3D.is_colliding():
		encounter = true
		
	if encounter:
		nav_agent.set_target_position(player.global_position)
		var next_nav_point = nav_agent.get_next_path_position()
		velocity = (next_nav_point - global_position).normalized() * SPEED
		#MAKE ENEMY STOP ROTATING UP AND DOWN RAH
		var hor_target = Vector3(player.global_position.x, global_position.y, player.global_position.z)
		look_at(hor_target, Vector3.UP)
	
	move_and_slide()
	
	
	
