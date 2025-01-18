extends CharacterBody3D

var SPEED = 12.0
var BOOST = 15.0
const JUMP_VELOCITY = 15.0


func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass


var rot = -0.02
var rot_x = 0 
var rot_y = 0

func _input(event):

	if Input.is_action_just_pressed("ui_cancel") and is_on_floor():
		get_tree().quit()

	if event is InputEventMouseMotion:
		if (rot_y + event.relative.y * rot) + 0.2 < 1 and (rot_y + event.relative.y * rot) - 0.2> -1:
			rot_y += event.relative.y * rot
			
		rot_x += event.relative.x * rot	
		transform.basis = Basis(Vector3(0,1,0), rot_x)
		$Camera3D.transform.basis = Basis(Vector3(1,0,0), rot_y)
		$SpotLight3D.transform.basis = Basis(Vector3(1,0,0), rot_y)
	
	
	
func _physics_process(delta):

	if position.y < -3.0:
		position.y = 0
		position.x = 0
		position.z = 0
		translate(Vector3(0,0,0))

	if not is_on_floor():
		velocity += get_gravity() / 10
		
	if Input.is_action_pressed("shift_run"):
		if SPEED <= BOOST:
			SPEED += 1
	else:
		SPEED = 5.0
		
		

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
