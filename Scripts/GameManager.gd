extends Node

#SCENES
const game_over_scene = preload("res://Scenes/gui/game_over.tscn")
const pause_scene = preload("res://Scenes/gui/pause.tscn")

func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			get_parent().get_node("pause").close()
		else:
			var pause = pause_scene.instance()
			get_parent().add_child(pause)

func game_over(final_score):
	get_tree().paused = true
	var game_over = game_over_scene.instance()
	game_over.setup(final_score)
	get_parent().add_child(game_over)
	

func _on_player_death(final_score):
	game_over(final_score)
