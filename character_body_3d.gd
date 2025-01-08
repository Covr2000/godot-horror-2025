extends CharacterBody3D

var SPEED = 50.0
const JUMP_VELOCITY = 20.5

var action_object = null
func action():
	#print("action do:", action_object)
	if action_object:
		if action_object.name == "door" or action_object.name == "door2":
			action_object.open()

func _ready():
	# что бы хвостик(кончик не отображался в квантах в окне игры
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

# переменные накопления движения курсора 
var rot = -0.02
var rot_x = 0 
var rot_y = 0

func _input(event):
	# ебучий выход старт 
	if Input.is_action_just_pressed("ui_cancel") and is_on_floor():
		get_tree().quit()
	# ебучий выход конец
	print($Camera3D.rotation.x, " ", rot_x)
	if $Camera3D.rotation.x > 1:	
		$Camera3D.rotation.x = 1
	elif $Camera3D.rotation.x < -1:
		$Camera3D.rotation.x = -1
	else:
		if event is InputEventMouseMotion:
			#print(event.relative)
			rot_x += event.relative.x * rot
			rot_y += event.relative.y * rot
			transform.basis = Basis(Vector3(0,1,0), rot_x)
			$Camera3D.transform.basis = Basis(Vector3(1,0,0), rot_y)
	
	if event is InputEventMouse:
		if event.is_pressed():
			action()
	
	
func _physics_process(delta):
	# что бы хуирло(игрок) не падал и тыпехлся на 0 0 0 старт
	if position.y < -3.0:
		position.y = 0
		position.x = 0
		position.z = 0
		translate(Vector3(0,0,0))
	# что бы хуирло(игрок) не падал и тыпехлся на 0 0 0 конец	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() / 10#delta
		
	if Input.is_action_pressed("shift_run"):
		SPEED = 100.0
	else:
		SPEED = 50.0
		
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
