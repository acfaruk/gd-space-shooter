extends Node

#SCENES
const game_over_scene = preload("res://Scenes/gui/game_over.tscn")

func game_over(final_score):
	get_tree().paused = true
	var game_over = game_over_scene.instance()
	game_over.setup(final_score)
	get_parent().add_child(game_over)
	

func _on_player_death(final_score):
	game_over(final_score)
