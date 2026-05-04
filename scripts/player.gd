class_name Player
extends CharacterBody3D

const SPEED = 5.0
const CROUCH_SPEED = 0.5
const JUMP_VELOCITY = 4.5
const CROUCH_STEP_INTERVAL = 0.8
const WALK_STEP_INTERVAL = 0.5
const SPRINT_STEP_INTERVAL = 0.3

@export var inv: Inv
#STAMMMMMM AJEASDKLF:JASDFGKL:JKL:ASJKL:F
@export var stamina_max : float = 100.0
@export var stamina_drain_rate : float = 20.0 
@export var stamina_regen_rate : float = 10.0 
@export var stamina_regen_delay : float = 2.0  

@onready var audio_flashlight = $audio_flashlight
@onready var audio_breath = $audio_breath
@onready var audio_footsteps = $audio_footsteps
@onready var audio_inventory = $audio_inventory

var stamina : float = 100.0
var regen_timer : float = 0.0
var can_sprint : bool = true
var is_crouching: bool = false
var footstep_timer : float = 0.0


func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	handle_movement(delta)
	handle_footsteps(delta)
	handle_crouch()
	handle_flashlight()
	move_and_slide()


func apply_gravity(delta) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


func handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		interrupt_regen()  # pauses regen on action


func handle_movement(delta) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED * (CROUCH_SPEED if is_crouching else 1.0)
		velocity.z = direction.z * SPEED * (CROUCH_SPEED if is_crouching else 1.0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	handle_stamina(delta)

	if Input.is_action_pressed("sprint") and can_sprint and stamina > 0:
		velocity.x = velocity.x * 1.5
		velocity.z = velocity.z * 1.5

func handle_footsteps(delta):
	if not is_on_floor() or not is_moving():
		footstep_timer = 0.0
		return
	var interval = SPRINT_STEP_INTERVAL if Input.is_action_pressed("sprint") and can_sprint \
	else CROUCH_STEP_INTERVAL if is_crouching \
	else WALK_STEP_INTERVAL
	
	footstep_timer -= delta
	if footstep_timer <= 0.0:
		$audio_footsteps.pitch_scale = randf_range(0.9,1.1)
		$audio_footsteps.play()
		footstep_timer = interval
		
func handle_stamina(delta) -> void:
	
		
	if Input.is_action_pressed("sprint") and stamina > 0 and is_moving() or Input.is_action_pressed("crouch") and stamina > 0:
		# drain
		if is_crouching:
			stamina -= stamina_drain_rate * delta * 0.3
		if is_moving():
			stamina -= stamina_drain_rate * delta
		stamina = max(stamina, 0.0)
		regen_timer = stamina_regen_delay  # keep resetting delay while sprinting
		if stamina == 0:
			
			can_sprint = false
			stop_crouching()
	else:
		# count down delay before regen
		if regen_timer > 0:
			regen_timer -= delta
		else:
			stamina = min(stamina + stamina_regen_rate * delta, stamina_max)
			if stamina >= stamina_max:
				can_sprint = true

	# update the UI bar
	update_stamina_bar()


func is_moving() -> bool:
	return Vector2(velocity.x, velocity.z).length() > 0.1


func interrupt_regen() -> void:
	regen_timer = stamina_regen_delay


func handle_crouch() -> void:
	if Input.is_action_just_pressed("crouch"):
		is_crouching = true
		scale = Vector3(.8333, .8333, .8333)
		audio_breath.play()
		audio_breath.finished.connect(_on_breath_finished)
	if Input.is_action_just_released("crouch"):
		is_crouching = false
		scale = Vector3(1, 1, 1)
		audio_breath.stop()

func _on_breath_finished():
	if is_crouching:
		audio_breath.play()

func handle_flashlight() -> void:
	if Input.is_action_just_pressed("toggle_flashlight"):
		$Head/Flashlight.visible = !$Head/Flashlight.visible
		audio_flashlight.play()


func update_stamina_bar() -> void:
	#STAMINA BAR UIIIIIII
	var ui = get_tree().get_first_node_in_group("ui")
	if ui:
		ui.set_stamina(stamina / stamina_max)

func stop_crouching():
	if not is_crouching:
		return
	is_crouching = false
	scale = Vector3(1,1,1)
	audio_breath.stop()
	if audio_breath.finished.is_connected(_on_breath_finished):
		audio_breath.finished.disconnect(_on_breath_finished)

func collect(item):
	inv.insert(item)



func _on_area_3d_body_entered(body):
	if body.name == "Enemy":
		$losescreen/TextureRect.visible = true
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
		GameState.set_state(GameState.MenuState.PAUSED)
