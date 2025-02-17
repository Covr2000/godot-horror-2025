extends Panel

signal Closing

func _on_button_close_pressed() -> void:
	Closing.emit()
