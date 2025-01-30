extends CharacterBody3D

# Minimum speed of the mob in meters per second.
@export var min_speed = 10
# Maximum speed of the mob in meters per second.
@export var max_speed = 18

# Скорость движения вперед
@export var speed: float = 5.0

var direction = Vector3.FORWARD.normalized()
var tracking = false



var stetat = false


# Генерация случайного направления
func get_random_direction_2d() -> Vector3:
	var angle = randf_range(0, 2 * PI)  # Случайный угол в радианах
	return Vector3(cos(angle), 0, sin(angle)).normalized()

@onready var a :AnimationPlayer = $Spooky_Summer_Nightmare_Girl_Sketchfab/AnimationPlayer
	
func _physics_process(_delta: float) -> void:
	if stetat == true:
		a.play("Girl_Anim_Following")
		look_at(GlobalPlayer.GPlayer, Vector3.UP)
		var direction1 = Vector3(0,0,-speed).rotated(Vector3.UP, rotation.y)
		velocity.z = direction1.z
		velocity.x = direction1.x
		move_and_slide()
	elif stetat == false:
		a.play("Girl_Anim_Walk")
		look_at(global_position + direction, Vector3.UP)
		velocity = direction * speed
		var collision = move_and_slide()
		#print(collision)
		if collision:
			direction = get_random_direction_2d()
			#движение в другую сторону
	
	
func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		stetat = true

	#print(body)
	#look_at(GlobalPlayer.GPlayer, Vector3.UP)
	pass # Replace with function body.


func _on_area_3d_body_exited(body):
	if body is CharacterBody3D:
		stetat = false
	pass # Replace with function body.
