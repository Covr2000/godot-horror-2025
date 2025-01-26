extends Area3D

func _ready():
	print(" Door Area3D готов. Коллизия активна:", monitoring)
	print("Слои Area3D:", collision_layer)
	print("Маски Area3D:", collision_mask)
	# Подключаем сигналы
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D):
	print("Тело вошло в область:", body.name)

func _on_body_exited(body: Node3D):
	print("Тело покинуло область:", body.name)
