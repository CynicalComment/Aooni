extends CharacterBody3D

const SPEED = 5.0

const JUMP_VELOCITY = 4.5

func _physics_process(delta):
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var input_dir := Input.get_vector("move_left","move_right","move_forward","move_backward")
	var direction := (transform.basis * Vector3(input_dir.x,0,input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x,0,SPEED)
		velocity.z = move_toward(velocity.z,0,SPEED)
		
	if Input.is_action_pressed("sprint"):
		velocity.x = velocity.x * 1.5
		velocity.z = velocity.z * 1.5
		#checkinggithub please do something
	if Input.is_action_pressed("crouch"):
		scale = Vector3(1,0.5,1)
	if Input.is_action_just_released("crouch"):
		scale = Vector3(1,1,1)
	if Input.is_action_just_pressed("toggle_flashlight"):
		$Head/Flashlight.visible = !$Head/Flashlight.visible
		
	move_and_slide()
		
	
	
