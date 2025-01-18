extends CharacterBody3D
var speed = 2
var accel = 10
@onready var nav: NavigationAgent3D = $NavigationAgent3D
#@onready var music_pos = get_node("res://scene_game/level/target.gd").pos_target

func _physics_process(delta):
	var direction = Vector3()
	
	nav.target_position = Global.global_position
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed , accel * delta)
	
	move_and_slide()
