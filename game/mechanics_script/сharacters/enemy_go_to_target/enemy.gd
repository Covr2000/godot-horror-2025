extends CharacterBody3D
var speed = 12
var accel = 10
@onready var nav: NavigationAgent3D = $NavigationAgent3D
#@onready var music_pos = get_node("res://scene_game/level/target.gd").pos_target


var last_value : Vector3
var used_values : Array = []

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


func _ready():
	GlobalPlayer.vector_arrayMarket.append(Vector3(-11.458, 2.99, 20.778))  
	GlobalPlayer.vector_arrayMarket.append(Vector3(34.748, 3.049,-2.599))  
	
	
var RAND_POSITION_MARKET = Vector3(0, 0, 0)
var POGRESHNOST = Vector3(0.5,10,0.5)

func _physics_process(delta):
	

	var ifing = velocity > (RAND_POSITION_MARKET - POGRESHNOST) and velocity < (RAND_POSITION_MARKET + POGRESHNOST)
	if ifing:
		print(ifing)
	print("velocity ",velocity, " RAND_POSITION_MARKET ", RAND_POSITION_MARKET, "\n", "RAND_POSITION_MARKET - POGRESHNOST", RAND_POSITION_MARKET - POGRESHNOST, " and " , RAND_POSITION_MARKET + POGRESHNOST)
	
	if ifing:
		RAND_POSITION_MARKET = get_random_vector(GlobalPlayer.vector_arrayMarket)
		print(RAND_POSITION_MARKET)
	
	var direction = Vector3()
	nav.target_position = RAND_POSITION_MARKET
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed , accel * delta)
	
	move_and_slide()
