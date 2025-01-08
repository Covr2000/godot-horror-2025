extends Node

#func _init(_name):
# 	name = _name
func say33(test):
	print(test)

# Called when the node enters the scene tree for the first time.
func _ready():
	var heman = load("res://node_3d.gd")
	var petr = heman.new()
	print(petr)
	petr.say33('xyi')
	petr._process(1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
