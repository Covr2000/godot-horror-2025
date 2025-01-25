extends CharacterBody3D

# Minimum speed of the mob in meters per second.
@export var min_speed = 10
# Maximum speed of the mob in meters per second.
@export var max_speed = 18

func _physics_process(_delta):
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	move_and_slide()
