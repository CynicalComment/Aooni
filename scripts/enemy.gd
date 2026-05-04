extends CharacterBody3D

const SPEED = 3.0

@export var chase_timer_MAX = 10 #actual timer length
@export var player_path : NodePath
@export var heartbeat_file : AudioStream

@onready var nav_agent = $NavigationAgent3D
@onready var shape_cast = $ShapeCast3D
@onready var music_heartbeat = $Audio_Heartbeat

var chase_timer : float = 0.0 #countdown value for timer
var player = null
var encounter = false

func _ready() -> void:
	player = get_node(player_path)
	music_heartbeat.stream = heartbeat_file
	music_heartbeat.stream.loop = true
	music_heartbeat.play()
func _physics_process(delta):
	velocity = Vector3.ZERO
	check_detection()	
	if encounter:
		chase_player()
		handle_chase_timer(delta)
		
	move_and_slide()
	
	
func chase_player():
	nav_agent.set_target_position(player.global_position)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_position).normalized() * SPEED
	#MAKE ENEMY STOP ROTATING UP AND DOWN RAH
	var hor_target = Vector3(player.global_position.x, global_position.y, player.global_position.z)
	look_at(hor_target, Vector3.UP)
	MusicPlayer.play_chase()
	
func check_detection():
	if shape_cast.is_colliding():
		encounter = true
		chase_timer = chase_timer_MAX
		
func handle_chase_timer(delta):
	if not shape_cast.is_colliding():
		chase_timer -= delta
		if chase_timer <= 0.0:
			despawn()
			

func _on_jumpscare():
	#NOT WORKING IDEK
	MusicPlayer.play_sting(preload("res://assets/music/playerdeath.wav"))
	
func despawn():
	encounter = false
	MusicPlayer.play_ambient()
	queue_free()
		
