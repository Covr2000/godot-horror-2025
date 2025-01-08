extends StaticBody3D

var opened = false
func open():
	# todo одна переменная для всех дверей
	if $anim.is_playing():
		return
		
	if !opened:
		$anim.play("left_door_anim")
		$'../../RightPivotDoor/door2/anim'.play("right_door_anim")
		opened = true
	else:
		$anim.play_backwards("left_door_anim")
		$'../../RightPivotDoor/door2/anim'.play_backwards("right_door_anim")
		opened = false
