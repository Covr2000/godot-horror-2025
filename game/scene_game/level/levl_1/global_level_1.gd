extends Node3D

@onready var a :AnimationPlayer = $katTest/Camera3D/AnimationPlayer
var local_anim_on = false


func _ready():
	#print($palyer.transform.origin)
	GlobalPlayer.GPlayerPosition_1 = $palyer.transform.origin 
	a.play("kat")
	
	
	
	
func _process(_delta):
	if local_anim_on == false:
		print(a.is_playing())
		if a.is_playing() != true:
			$katTest.queue_free()
			local_anim_on = true
	pass
	
	
	# получить все лампочки и видны ли они или нет
