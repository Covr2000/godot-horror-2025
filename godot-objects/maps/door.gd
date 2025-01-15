extends Node3D

func _on_area_3d_area_entered(area: Area3D) -> void:
	$anim.play("horizontal_open_doors")
	print("open door")


func _on_area_3d_area_exited(area: Area3D) -> void:
	$anim.play_backwards("horizontal_open_doors")
	print("close door")
