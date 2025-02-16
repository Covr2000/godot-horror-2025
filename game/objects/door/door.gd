extends Node3D

@onready var a :AnimationPlayer = $anim

func _ready() -> void:
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	#print(3, body)
	if body is CharacterBody3D:
		a.play("horizontal_open_doors")


func _on_area_3d_body_exited(body: Node3D) -> void:
	#print(4, body)
	if body is CharacterBody3D:
		a.play_backwards("horizontal_open_doors")
