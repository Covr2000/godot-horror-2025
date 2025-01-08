extends WorldEnvironment

# Скорость вращения неба (в радианах в секунду)
@export var sky_rotation_speed: float = 0.1


func _process(delta: float) -> void:
	if environment:
		# Увеличиваем вращение неба
		environment.sky_rotation.y += sky_rotation_speed * delta
		# Ограничиваем вращение в пределах 0-2π (опционально)
		#environment.sky_rotation.y = fmod(environment.sky_rotation.y, TAU)
