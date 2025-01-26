extends CharacterBody3D

var stetat = false
var speed: float = 5.0

#var direction = Vector3.RIGHT.normalized()

func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if stetat:
		look_at(GlobalPlayer.GPlayer, Vector3.UP)
		var direction = Vector3(0,0,-speed).rotated(Vector3.UP, rotation.y)
		velocity.z = direction.z
		velocity.x = direction.x
		move_and_slide()
	#print(GlobalPlayer.GPlayer)
	
	#pass


#func _on_area_3d_area_entered(area):
	#print(1)
	#pass # Replace with function body.

	


func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		stetat = true
		print(body)

	#print(body)
	#look_at(GlobalPlayer.GPlayer, Vector3.UP)
	pass # Replace with function body.


func _on_area_3d_body_exited(body):
	if body is CharacterBody3D:
		stetat = false
	pass # Replace with function body.
