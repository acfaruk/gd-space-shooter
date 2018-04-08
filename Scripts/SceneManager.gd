extends Node

enum SCENE {MAIN_MENU, MAIN}

#SCENES
const main_menu_scene = preload("res://Scenes/gui/main_menu.tscn")
const main_scene = preload("res://Scenes/main.tscn")

var current_scene = SCENE.MAIN_MENU

func change_to_scene(scene):
	match scene:
		SCENE.MAIN:
			get_tree().change_scene_to(main_scene)
		SCENE.MAIN_MENU:
			get_tree().change_scene_to(main_menu_scene)