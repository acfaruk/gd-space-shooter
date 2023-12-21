extends Node

#SCENES
@export var game_over_scene: PackedScene
@export var pause_scene: PackedScene
@export var settings_scene: PackedScene

var is_game_over = false

func _input(event):
	if event.is_action_pressed("pause") && !is_game_over:
		var pause = get_parent().has_node("pause")
		if pause:
			var current_pause = get_parent().get_node("pause")
			current_pause.close()
		else:
			var new_pause = pause_scene.instantiate()
			get_parent().add_child(new_pause)

func game_over(final_score):
	is_game_over = true
	get_tree().paused = true
	var game_over = game_over_scene.instantiate()
	game_over.setup(final_score)
	get_parent().add_child(game_over)

func _on_player_death(final_score):
	game_over(final_score)

#GROUP restartable
func restart():
	is_game_over = false
	get_tree().paused = false
