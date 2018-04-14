extends CanvasLayer

var menu
var settings

func _ready():
	menu = $menu
	settings = $settings_sub
	
func _on_play_pressed():
	SceneManager.change_to_scene(SceneManager.SCENE.MAIN)

func _on_settings_pressed():
	menu.hide()
	settings.show()
	
func _on_quit_pressed():
	get_tree().quit()

func back():
	menu.show()
	settings.hide()