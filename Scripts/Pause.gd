extends CanvasLayer

func _ready():
	get_tree().paused = true

func close():
	get_tree().paused = false
	queue_free()

func _on_resume_pressed():
	close()

func _on_quit_pressed():
	get_tree().quit()
