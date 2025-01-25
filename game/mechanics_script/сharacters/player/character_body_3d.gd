extends CharacterBody3D

# Инициализация переменных скорости
var SPEED = 0.0 # Просто создание скорости типа floot
var MIN_SPEED = 5.0 # Стартовая или начальная скорость 
var MAX_SPEED = 15.0 # Максимальная скорость 
var BOOST = 0.5 # Ускорение

const JUMP_VELOCITY = 15.0 # Высота прыжка

# Функция при четение но наверное правильно будет сделать через _init, 
	#по есть при создания объекта
func _ready():
	# Блокировка мышки что бы ее не было вижно и не выходила за пределы экранна
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 
	pass



# fov run, Угол обзора увеличиваеться при беге а это просто увелечение
const FOV = 70 # потом брать из настроек
const FOV_RUN_OPT = 0.5 # На сколько увеличивать при беге


# Мы берем отрезок от начала движения мышки вот и его накапливаем
# sensivite, переменные как сохрание буфера накопления вращения
var rot = -0.01
var rot_x = 0 
var rot_y = 0

# Функция отлова ввода, аргумент события
func _input(event):
	#if Input.is_action_just_pressed("ui_cancel") and is_on_floor():
		#get_tree().quit()

	# Накапливаем отрезок по "У", "X" по движению, если есть движение мышкой
	if event is InputEventMouseMotion:
		if (rot_y + event.relative.y * rot) + 0.2 < 1 and (rot_y + event.relative.y * rot) - 0.2> -1: # Ограничение что бы персонаж не закручивал голову назад 
			rot_y += event.relative.y * rot
		rot_x += event.relative.x * rot	

		
		# Передаем значение камере и псевдо фонарику
		transform.basis = Basis(Vector3(0,1,0), rot_x)
		$Camera3D.transform.basis = Basis(Vector3(1,0,0), rot_y)
		$SpotLight3D.transform.basis = Basis(Vector3(1,0,0), rot_y) # Псевдо фонарик
	

var bt = 0.0
	
func _physics_process(delta):

	if position.y < -100.0:
		position.y = 0
		position.x = 0
		position.z = 0
		translate(Vector3(0,0,0))

	if not is_on_floor():
		velocity += get_gravity() / 10
		
	if Input.is_action_pressed("shift_run"):
		if SPEED <= MAX_SPEED:
			SPEED += BOOST
	else:
		SPEED = MIN_SPEED



	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
	velocity.x = velocity.x 
	velocity.y = velocity.y
	
	bt = bt + delta * velocity.length() * float(is_on_floor())
	$Camera3D.transform.origin = sinCamera(bt)
	
	#fov_run_change
	var vel_cl = clamp(velocity.length(), 0.5, SPEED)
	var target_fov = FOV - FOV_RUN_OPT * vel_cl
	$Camera3D.fov = lerp($Camera3D.fov, target_fov, delta * 1.0)
	move_and_slide()

func sinCamera(bt):
	var pos = Vector3.ZERO
	# 1.9 высота над камерой 
	pos.y = 1.9 + (sin(bt * 1.0) * 0.05)
	pos.x = cos(bt * 1.0 / 2) * 0.05
	return pos


# закрытие игры без багов и задержек с остановкой игры 
	# как именно работает не совсем понял
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("ui_cancel"):
		match Input.mouse_mode:
			Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				get_tree().paused = true
				self.show()
				get_tree().quit()  
			Input.MOUSE_MODE_VISIBLE:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				get_tree().paused = false
				self.hide()
				get_tree().quit()  
