extends Node

onready var world = get_node("/root/main")
onready var main_cam = get_node("/root/main/player/cam")

var meteor_scene = preload("res://Scenes/Meteor.tscn")

export (int) var max_meteor_distance_squared = 2000*2000
export (int) var min_meteor_distance = 1050
export (int) var max_meteors = 20

var meteors = []

func _physics_process(delta):
	despawn_meteors()
	spawn_meteors()

func despawn_meteors():
	for meteor in meteors:
		if meteor.position.distance_squared_to(main_cam.get_camera_position()) > max_meteor_distance_squared:
			meteor.queue_free()
			meteors.erase(meteor)

func spawn_meteors():
	if meteors.size() < max_meteors:
		var meteor = meteor_scene.instance()
		meteors.append(meteor)
		
		var dist = randi() % 200 + min_meteor_distance
		var rot = randi() % 360
		
		meteor.position = main_cam.get_camera_position()
		meteor.rotation_degrees = rot
		meteor.move_local_y(-dist)
		world.add_child(meteor)