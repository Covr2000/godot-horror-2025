extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play() -> void:
	get_tree().change_scene_to_file("res://scenes/level/levl_1/level1.tscn")


func _on_settings() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/setting/SettingsWindow.tscn")


func _on_license() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/license/authors_and_license.tscn")


func _on_exit() -> void:
	get_tree().quit()
