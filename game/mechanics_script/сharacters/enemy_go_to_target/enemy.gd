extends CharacterBody3D
var speed = 12.1


var accel = 10
@onready var nav: NavigationAgent3D = $NavigationAgent3D
#@onready var music_pos = get_node("res://scene_game/level/target.gd").pos_target


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

# Так добовляю тестовую точку для передвижения
func _ready():
	GlobalPlayer.vector_arrayMarket.append(Vector3(-11.458, 2.99, 20.778))  

	
var RAND_POSITION_MARKET = Vector3(0,0,0)
var POGRESHNOST = Vector3(0.1,10,0.11)

func _physics_process(delta):
	
	
	var direction = Vector3()
	nav.target_position = RAND_POSITION_MARKET
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed , accel * delta)
	look_at(global_position + direction, Vector3.UP)

	var ifing = velocity == RAND_POSITION_MARKET 
	
	#print("velocity ",velocity, " RAND_POSITION_MARKET ", RAND_POSITION_MARKET, "\n", "RAND_POSITION_MARKET - POGRESHNOST", RAND_POSITION_MARKET - POGRESHNOST, " and " , RAND_POSITION_MARKET + POGRESHNOST)
	
	var position_enemy = transform.origin + Vector3(-13.651, 0,-18.148)
	if  position_enemy > RAND_POSITION_MARKET - POGRESHNOST and position_enemy < RAND_POSITION_MARKET + POGRESHNOST:
		RAND_POSITION_MARKET = get_random_vector(GlobalPlayer.vector_arrayMarket)
		
		
	move_and_slide()
