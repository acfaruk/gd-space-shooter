extends Node

#SCENES
const meteor_scene = preload("res://Scenes/meteors/big_meteor.tscn")

#EXPORT
export (int) var max_meteor_distance_squared = 2000*2000
export (int) var min_meteor_distance = 1050
export (int) var max_meteors = 30

#VARS
var meteors = []
var player

func _ready():
	player = get_parent().find_node("player")

func _physics_process(delta):
	despawn_meteors()
	spawn_meteors()

func _get_spawn_position():
	if player != null:
		return player.position
	else:
		return OS.window_size / 2

func despawn_meteors():
	for meteor in meteors:
		if meteor.position.distance_squared_to(_get_spawn_position()) > max_meteor_distance_squared:
			meteor.destroy()

func spawn_meteors():
	if meteors.size() < max_meteors:
		var meteor = meteor_scene.instance()
		var distance = randi() % 200 + min_meteor_distance
		meteor.setup(_get_spawn_position(), self, distance)
		get_parent().add_child(meteor)
		
func remove_meteor(meteor):
	meteors.erase(meteor)
	
func add_meteor(meteor):
	meteors.append(meteor)
	