extends CharacterBody3D
class_name PlayerCharacter

@onready var cam = $"%Camera3D"

func _ready() -> void:
	cam.current = true
	GlobalPlayer.player = self

const SPEED = 5.0
const JUMP_VELOCITY = 10.5

var rot = -0.01
var rot_x = 0 
var rot_y = 0

	
func _input(event):
	#if Input.is_action_just_pressed("ui_cancel") and is_on_floor():
		#get_tree().quit()

	# Накапливаем отрезок по "У", "X" по движению, если есть движение мышкой
	if event is InputEventMouseMotion:
		if (rot_y + event.relative.y * rot) + 0.2 < 1 and (rot_y + event.relative.y * rot) - 0.2> -1: # Ограничение что бы персонаж не закручивал голову назад 
			rot_y += event.relative.y * rot
		rot_x += event.relative.x * rot	
		# Передаем значение камере и псевдо фонарику
		cam.transform.basis = Basis(Vector3(0,1,0), rot_x)
		transform.basis = Basis(Vector3(0,1,0), rot_x)
		

		cam.transform.basis = Basis(Vector3(1,0,0), rot_y)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 2

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

# fast exit
#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventKey and event.is_action_pressed("ui_cancel"):
		#get_tree().quit()  
