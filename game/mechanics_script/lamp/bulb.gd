extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#$anim.play("anim_lie")


# работает?
func _process(delta: float) -> void:
	rotation_degrees.y = 180*delta
	pass

@onready var obj = get_parent()
@onready var listobj = obj.get_parent()

func _on_area_3d_body_entered(_body: Node3D) -> void:
	#print("lamp in ", is_visible_in_tree())
	if is_visible_in_tree():
		obj.hide()
		listobj.recalcSumObjects()
	#queue_free() # Удаляем текущий объект
