extends Node

#SCENES
const meteor_scene = preload("res://Scenes/meteors/big_meteor.tscn")

#EXPORT
export (NodePath) var world_path
export (NodePath) var player_path
export (int) var max_meteor_distance_squared = 2000*2000
export (int) var min_meteor_distance = 1050
export (int) var max_meteors = 30

#NODES
onready var world = get_node(world_path)
onready var player = get_node(player_path)

#VARS
var meteors = []

func _physics_process(delta):
	despawn_meteors()
	spawn_meteors()

func despawn_meteors():
	for meteor in meteors:
		if meteor.position.distance_squared_to(player.position) > max_meteor_distance_squared:
			meteor.destroy()

func spawn_meteors():
	if meteors.size() < max_meteors:
		var meteor = meteor_scene.instance()
		var distance = randi() % 200 + min_meteor_distance
		meteor.setup(player.position, self, distance)
		world.add_child(meteor)
		
func remove_meteor(meteor):
	meteors.erase(meteor)
	
func add_meteor(meteor):
	meteors.append(meteor)