extends CanvasLayer

var menu
var settings

func _ready():
	get_tree().paused = true
	menu = $menu
	settings = $settings_sub

func close():
	get_tree().paused = false
	queue_free()

func _on_resume_pressed():
	close()

func _on_settings_pressed():
	menu.hide()
	settings.show()

func _on_quit_pressed():
	get_tree().quit()

func back():
	menu.show()
	settings.hide()
