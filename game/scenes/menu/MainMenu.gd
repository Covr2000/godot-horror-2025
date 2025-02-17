extends Control

@onready var buttons = $VBoxContainer
@onready var settings = $Settings
@onready var info = $License

func _on_play() -> void:
	get_tree().change_scene_to_file("res://scenes/level/levl_1/level1.tscn")

func _on_settings() -> void:
	settings.show()
	buttons.hide()
	
func _on_settings_closing() -> void:
	settings.hide()
	buttons.show() 
	
func _on_license() -> void:
	info.show()
	buttons.hide()
	
func _on_license_closing() -> void:
	info.hide()
	buttons.show() 

func _on_exit() -> void:
	self.get_tree().quit()
