extends Node

var pickups = []
var player

func _ready():
	#init array of pickups like this, since exporting arrays of PackedScenes is bugged right now..
	pickups = [
		load("res://Scenes/pickups/health_pickup.tscn"),
		load("res://Scenes/pickups/energy_pickup.tscn")
	]
	player = get_node("/root/main/player")

func _on_pickup_timer_timeout():
	var random_pickup_scene = pickups[randi() % pickups.size() - 1]
	var size = get_viewport().size
	var x = (randi() % int(size.x)) - (int(size.x/2)) + player.position.x
	var y = (randi() % int(size.y)) - (int(size.y/2)) + player.position.y
	var random_pickup = random_pickup_scene.instance()
	random_pickup.setup(Vector2(x,y))
	get_parent().add_child(random_pickup)