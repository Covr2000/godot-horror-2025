extends CharacterBody3D

# Minimum speed of the mob in meters per second.
@export var min_speed = 10
# Maximum speed of the mob in meters per second.
@export var max_speed = 18

# Скорость движения вперед
@export var speed: float = 5.0

var direction = Vector3.BACK.normalized()
var tracking = false

# Генерация случайного направления
func get_random_direction_2d() -> Vector3:
	var angle = randf_range(0, 2 * PI)  # Случайный угол в радианах
	return Vector3(cos(angle), 0, sin(angle)).normalized()

func _physics_process(delta: float) -> void:
	look_at(global_position + direction, Vector3.UP)
	velocity = -direction * speed
	var collision = move_and_slide()
	print(collision)
	if collision:
		direction = get_random_direction_2d()
		#движение в другую сторону
		#tracking = !tracking
		#
	#if tracking:
		#direction = Vector3.FORWARD.normalized()
	#else:
		#direction = Vector3.BACK.normalized()

	
