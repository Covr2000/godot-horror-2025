extends Node3D

var count_get_objects = 0
var count_need_objects = 3

func recalcSumObjects():
	if count_get_objects < count_need_objects:
		count_get_objects += 1
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$lblCountObjects.text = str(count_get_objects) + " / " + str(count_need_objects)
	
	pass
