extends Panel

# Панель настроек

# доступ по уникальному имени (надо лкм на объект и "Доступ как к уникальному") или
#@onready var ResolutionOption2 = find_child("OptionButtonResolution", true, false)
@onready var ResolutionOption = $"%OptionButtonResolution" 
@onready var FullscreenToggle = $"%CheckBoxFullScreen"
@onready var VSyncToggle = $"%CheckBoxVSync"
@onready var AudioSlider = $"%HSliderVolume"
@onready var SensSlider = $"%HSliderSensitiveMouse"

signal Closing

func _ready():
	for i in range(ResolutionOption.item_count):
		var text = ResolutionOption.get_item_text(i)
		var r = SettingsHandler._get_resolution_as_str()
		if text == r:
			ResolutionOption.selected = i
			break
	FullscreenToggle.button_pressed = SettingsHandler.get_value("fullscreen")
	VSyncToggle.button_pressed = SettingsHandler.get_value("vsync")
	AudioSlider.value = SettingsHandler.get_value("volume")
	SensSlider.value = SettingsHandler.get_value("sensitivity")

func _on_apply_settings() -> void:
	SettingsHandler.SettingsDict = SettingsHandler.DEFAULT_SETTINGS.duplicate(true)
	
	var resolution = ResolutionOption.get_item_text(ResolutionOption.selected)
	var fullscreen = FullscreenToggle.button_pressed
	var vsync = VSyncToggle.button_pressed
	resolution = resolution.split("x")
	resolution = [int(resolution[0]), int(resolution[1])]
	
	SettingsHandler.SettingsDict["resolution"] = resolution
	SettingsHandler.SettingsDict["vsync"] = vsync
	SettingsHandler.SettingsDict["fullscreen"] = fullscreen
	SettingsHandler.SettingsDict["volume"] = AudioSlider.value
	SettingsHandler.SettingsDict["sensitivity"] = SensSlider.value
	
	SettingsHandler._apply_settings()
	SettingsHandler._save_settings()
	_on_close()

func _on_close():
	Closing.emit()
	self.hide()
