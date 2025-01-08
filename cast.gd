extends Area3D

func _on_body_entered(body: Node3D) -> void:
	# задаем для player переменную action_object в body
	$'../../'.action_object = body
	print("see :", body.name)

func _on_body_exited(body: Node3D) -> void:
	$'../../'.action_object = null
	print("NOT see :", body.name)
