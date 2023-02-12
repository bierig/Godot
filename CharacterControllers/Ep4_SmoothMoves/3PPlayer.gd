extends KinematicBody
export var speed := 20
export var gravity := 20 # change
export var acc_h := 35
export var acc_v := 35
var velocity := Vector3.ZERO
var snap := Vector3.DOWN
export var jump_intensity = 10
var jumps = 0
func _physics_process(delta):
	var direction = Vector3.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.z = Input.get_axis("move_up", "move_down")
	direction = direction.limit_length(1.0)
	velocity.x = move_toward(velocity.x, direction.x * speed, acc_h * delta)
	velocity.z = move_toward(velocity.z, direction.z * speed, acc_h * delta)
	velocity.y = move_toward(velocity.y, -gravity, acc_v * delta)
	var jumping := is_on_floor() and snap == Vector3.DOWN and Input.is_action_just_pressed("move_jump")
	var falling := !is_on_floor() and snap == Vector3.ZERO
	var landing := is_on_floor() and snap == Vector3.ZERO
	if jumping:
		velocity.y = jump_intensity
		snap = Vector3.ZERO
		jumps += 1
	elif falling:
		if Input.is_action_just_pressed("move_jump") && jumps <= 1:
			velocity.y = jump_intensity
			jumps += 1
	elif landing:
		snap = Vector3.DOWN
		jumps = 0
	move_and_slide_with_snap(velocity, snap, Vector3.UP, true)
