extends CanvasLayer

func setup(final_score):
	find_node("score").text = "Your Score: " + str(final_score)

func _on_restart_pressed():
	get_tree().current_scene.find_node("player").respawn()
	get_parent().remove_child(self)
	queue_free()

func _on_quit_pressed():
	get_tree().quit()
