extends CanvasLayer

func _on_play_pressed():
	SceneManager.change_to_scene(SceneManager.SCENE.MAIN)

func _on_quit_pressed():
	get_tree().quit()
