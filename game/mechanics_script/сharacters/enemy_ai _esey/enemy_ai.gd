extends CharacterBody3D

@onready var nav: NavigationAgent3D = $NavigationAgent3D                                  # Навигация врага по карте
@onready var ray_cast: RayCast3D = $"../RayCast3D"                                           # RayCast для видимости игрока, что бы он не видел игрока сквозь сцены
@onready var a: AnimationPlayer = $Spooky_Summer_Nightmare_Girl_Sketchfab/AnimationPlayer # Получение ссылки на AnimationPlayer

var min_speed = 10      # Минимальная скорость движения моба в метрах в секунду.
var max_speed = 18      # Максимальная скорость движения моба в метрах в секунду.
var speed: float = 12.0 # Начальная скорость движения вперед



# Состояния врага
const state_enemy: Array[String] = [
	"attack",      # 0 Атака 
	"chasing",     # 1 Погоня (после обнаружения игрока) 1
	"wandering",   # 2 Блуждание
	"patrol",      # 3 Патрулирование или перемещение по заданным точкам
	"calmness"     # 4 Спокойствие
]


var direction = Vector3.FORWARD.normalized() # Начальное направление движения (вперед по оси Z)
var tracking = false # Флаг, указывающий, обнаружен ли игрок
var stetat = state_enemy[3] # Флаг состояния (активностный)

var accel = 10



var last_value : Vector3
var used_values : Array = []


# Функция для получения рандомного вектора
func get_random_vector(vectors: Array) -> Vector3:
	if used_values.size() == vectors.size():
		used_values.clear()
	
	var random_index: int
	var new_value: Vector3
	
	# Генерируем новый индекс до тех пор, пока не найдем вектор, не равный последнему использованному
	while true:
		random_index = randi() % vectors.size()
		new_value = vectors[random_index]
		if new_value != last_value and not used_values.has(new_value):
			last_value = new_value
			used_values.append(last_value)
			return new_value
	return new_value


var RAND_POSITION_MARKET = Vector3() # Так добовляю тестовую точку для передвижения
var POGRESHNOST = Vector3(0.1,10,0.11)

# Так добовляю тестовую точку для передвижения
func _ready():
	## GlobalPlayer.vector_arrayMarket.append(Vector3(-11.458, 2.99, 20.778))  
	ray_cast.enabled = true # Включите RayCast3D чтобы он работал
	

# Генерация случайного направления в 2D
func get_random_direction_3d() -> Vector3:
	var angle = randf_range(0, 2 * PI)  # Случайный угол в радианах
	return Vector3(cos(angle), 0, sin(angle)).normalized() # Возвращаем нормализованное направление вектора на основе случайного угла

func can_see_player() -> bool:
	if ray_cast.is_colliding():
		print("call can_see_player true") # Если что-то столкнулось, значит, между врагом и игроком есть препятствия
		var collider = ray_cast.get_collider() 
		if collider is CharacterBody3D:
			return true # Враг видит игрока
	return false # Враг не видит игрока

	
# Основной метод, обрабатывающий физику
func _physics_process(delta: float) -> void:
	match stetat:
		"attack":
			#if can_see_player(): # Проверяем, видит ли враг игрока
			a.play("Girl_Anim_Following")  # Воспроизводим анимацию следования
			look_at(GlobalPlayer.GPlayer, Vector3.UP)  # Повернуться к игроку
			var direction1 = Vector3(0, 0, -speed).rotated(Vector3.UP, rotation.y)  # Получаем направление движения
			velocity.z = direction1.z  # Установка скорости по оси Z
			velocity.x = direction1.x  # Установка скорости по оси X
			move_and_slide()  # Применение движения с учетом столкновений
			#else:
				# Если враг не видит игрока, вернуться в состояние "патрулирование"
			#stetat = "patrol"
		"wandering":
			a.play("Girl_Anim_Walk")  # Воспроизводим анимацию ходьбы
			look_at(global_position + direction, Vector3.UP)  # Повернуться в текущее направление движения
			velocity = direction * speed  # Устанавливаем скорость по текущему направлению
			var collision = move_and_slide()  # Применение движения с учетом столкновений
			if collision:
				# Если произошло столкновение, сгенерируем новое случайное направление
				direction = get_random_direction_3d()
		"patrol":
			a.play("Girl_Anim_Walk")  # Воспроизводим анимацию ходьбы
			var direction = Vector3()
			nav.target_position = RAND_POSITION_MARKET
			direction = nav.get_next_path_position() - global_position
			direction = direction.normalized()
			velocity = velocity.lerp(direction * speed , accel * delta)
			
			
			look_at(global_position + direction, Vector3.UP)
			
			
			var position_enemy = transform.origin + Vector3(0, -0.125368, 0)
			if  position_enemy > RAND_POSITION_MARKET - POGRESHNOST and position_enemy < RAND_POSITION_MARKET + POGRESHNOST:
				RAND_POSITION_MARKET = get_random_vector(GlobalPlayer.vector_arrayMarket)
			move_and_slide()
			#print("position_enemy", position_enemy, " RAND_POSITION_MARKET", RAND_POSITION_MARKET)



# Обработка входа в область
func _on_area_3d_body_entered(body):
	# Если объект, вошедший в область, является игроком
	if body is CharacterBody3D:
		stetat = "attack"  # Изменение состояния на "включено"
		print("attack")  # Можно раскомментировать для отладки

# Обработка выхода из области
func _on_area_3d_body_exited(body):
	# Если объект, вышедший из области, является игроком
	if body is CharacterBody3D:
		stetat = "patrol"  # Изменение состояния на "выключено"
		print("patrol")  # Можно раскомментировать для отладки


func _on_ray_cast_3d_visibility_changed():
	can_see_player()
	pass # Replace with function body.

# если ты проиграл закрытие игры
func _on_area_3d_2_body_entered(body):
	if body is CharacterBody3D:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
		self.show()
		get_tree().quit()  
	pass # Replace with function body.
