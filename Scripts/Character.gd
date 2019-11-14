extends KinematicBody

var gravity = Vector3.DOWN * 12
var speed = 4
var jump_speed = 6
var spin = 0.1

var velocity = Vector3()
var jump = false

func _physics_process(delta):
	velocity += gravity *delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)
	if jump and is_on_floor():
		velocity.y = jump_speed
	
func get_input():
	var vy = velocity.y
	velocity = Vector3()
	if Input.is_action_pressed("Move_Forward"):
		velocity += -transform.basis.z * speed
	if Input.is_action_pressed("Move_Back"):
		velocity += transform.basis.z * speed
	if Input.is_action_pressed("Move_Right"):
		velocity += transform.basis.x * speed
	if Input.is_action_pressed("Move_Left"):
		velocity += -transform.basis.x * speed
	velocity.y = vy
	jump = false
	if Input.is_action_just_pressed("Jump"):
		jump = true
		
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-lerp(0, spin, event.relative.x/10))