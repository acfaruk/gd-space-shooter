extends Container

var music_slider
var sfx_slider

func _ready():
	music_slider = find_node("music_slider")
	sfx_slider = find_node("sfx_slider")
	music_slider.value = AudioServer.get_bus_volume_db(1)
	sfx_slider.value = AudioServer.get_bus_volume_db(2)

func _on_back_button_pressed():
	get_parent().back()

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)
