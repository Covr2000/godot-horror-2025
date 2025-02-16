extends Node3D

@onready var lbl = $"../lblLamps"
var count_collected = 0
var count_need_collect = 5

func recalcSumObjects():
	if count_collected < count_need_collect:
		count_collected += 1

func _ready() -> void:
	print(lbl)
	start_timer()
	
func _process(delta: float) -> void:
	if count_collected < count_need_collect:
		lbl.text = "ZAбрано лYмпачек\n" + str(count_collected) + " / " + str(count_need_collect)
	else:
		lbl.text = "Конец (тебе)"
		
func start_timer() -> void:
	var timer = get_tree().create_timer(5)
	timer.timeout.connect(change_active_objects)

func change_active_objects() -> void:
	#сохраняем в массив все не включенные лампочки
	var arr_not_visible : Array[Node]
	var visible_objects = 0
	for child in get_children():
		if !child.visible:
			arr_not_visible.push_back(child)
		else:
			visible_objects += 1
		#print("Child node:", child.name, " ", child.visible)
	var need_to_show = count_need_collect - count_collected - visible_objects
	#print("lamps need_to_show:", need_to_show)
	# делаем от 3 лампочек видимыми и удаляем из массива спрятанных
	for i in range(min(3, need_to_show)):
		if !arr_not_visible.is_empty():
			var random_index = randi() % arr_not_visible.size()
			arr_not_visible[random_index].show()
			arr_not_visible.pop_at(random_index)
	start_timer()
