extends Node3D

var i = 0
func mynt123():
	var i = i


#Событие вызываешие при включения объекта в древе сцен(сихроное или асихроное не знаю)
func _ready():
	print('Вывод информации'); # Вывод информации в консоль 
	
	var test = 0; # Переменная не строго типизированная
	print('Вывод test: ',test); # Вывод переменной 
	
	var test2 = 0; # Переменная не строго типизированная
	print('Вывод сравнения типизаци инт test2: ', typeof(test2) == TYPE_INT); # Проверка на соотвествие 
	
	# Язык не строго типизирован по этому можно менять значения
	var test3 = 0; # Переменная не строго типизированная
	test3 = '33';
	print('Вывод переопления в string test3: ',typeof(test3) == TYPE_INT); # Проверка на соотвествие 
	
	# Список состоит из разных типизациях. Масив строго типизирован
	var arr = [-108,'хуй', 2.34, true];
	print(arr);
	
	var bar = arr;
	bar[0] = 1;
	
	print(arr);
	# Массив ибо список, это небор ссылок
	
	# test залупы и хуя
	var xyi = 1;
	var zalupa = xyi;
	zalupa = 5;
	
	print(xyi)
	# test залупы и хуя
	
	# Теперь ебучий вопрос как оставить старый список и записать значения из списка в новый список что бы им пользоваться но старый остался не тронутым? 
	var arr_test = [-108,'хуй', 2.34, true];
	print(arr_test);
	var bar1_test = [];
	bar1_test.append_array(arr_test);
	bar1_test[0] = 1
	print("\n",arr_test);
	print(bar1_test,"\n");
	# Массив ибо список, это небор ссылок
	
	# массив но только словарь
	var obj = {
		'kay': 15
	};
	
	print(obj['kay'], '\n')
	print('var a = ', ('25' if 1 == 1 else 'другое значение'))

		
	var i = mynt123()
	var i1 = i
	if i:
		print('xyi')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
