extends Node3D




func _ready():
	#print($palyer.transform.origin)
	GlobalPlayer.GPlayerPosition_1 = $palyer.transform.origin 
	
	# получить все лампочки и видны ли они или нет
