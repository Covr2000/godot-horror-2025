extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$anim.play("anim_lie")


# работает?
func _process(delta: float) -> void:
	rotation_degrees.y = 180*delta
	pass


func _on_area_3d_area_entered(area: Area3D) -> void:
	#hide()
	$'../../'.recalcSumObjects()
	#queue_free() # Удаляем текущий объект
