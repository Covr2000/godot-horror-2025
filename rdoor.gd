extends StaticBody3D

var opened = false
func open():
	if $anim.is_playing():
		return
		
	if !opened:
		$anim.play("right_door_anim")
		$'../../LeftPivotDoor/door/anim'.play("left_door_anim")
		opened = true
	else:
		$anim.play_backwards("right_door_anim")
		$'../../LeftPivotDoor/door/anim'.play_backwards("left_door_anim")
		opened = false
