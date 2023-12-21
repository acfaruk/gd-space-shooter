extends Node

#SCENES
@export var meteor_scene: PackedScene

#EXPORT
@export var max_meteor_distance_squared: int = 1500*1500
@export var min_meteor_distance: int = 900
@export var max_meteors: int = 50

#VARS
var meteors = []
var player

func _ready():
	player = get_parent().find_child("player")

func _physics_process(_delta):
	despawn_meteors()
	spawn_meteors()

func _get_spawn_position():
	if player != null:
		return player.position
	else:
		return get_window().size / 2

func despawn_meteors():
	for meteor in meteors:
		if meteor.position.distance_squared_to(_get_spawn_position()) > max_meteor_distance_squared:
			meteor.destroy()

func spawn_meteors():
	if meteors.size() < max_meteors:
		var meteor = meteor_scene.instantiate()
		var distance = randi() % 100 + min_meteor_distance
		meteor.setup(_get_spawn_position(), self, distance)
		get_parent().add_child(meteor)
		
func remove_meteor(meteor):
	meteors.erase(meteor)
	
func add_meteor(meteor):
	meteors.append(meteor)

#GROUP restartable
func restart():
	for meteor in meteors:
		meteor.destroy()
