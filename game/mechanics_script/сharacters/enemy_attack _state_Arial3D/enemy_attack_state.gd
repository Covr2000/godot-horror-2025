extends CharacterBody3D

var stetat
var speed: float = 5.0

var direction = Vector3.BACK.normalized()

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(GlobalPlayer.GPlayer, Vector3.UP)
	#velocity = -direction * speed
	#move_and_slide()
	pass
