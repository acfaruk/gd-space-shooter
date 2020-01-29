extends Node

enum ENEMY_TYPE {SIMPLE}

export (PackedScene) var simple_enemy

var player

func _ready():
	player = get_parent().find_node("player")

func _on_spawn_timer_timeout():
	spawn_enemy(ENEMY_TYPE.SIMPLE)

func spawn_enemy(type):
	match type:
		ENEMY_TYPE.SIMPLE:
			var new_enemy = simple_enemy.instance()
			new_enemy.setup(player.position)
			get_parent().add_child(new_enemy)

#GROUP Restartable
func restart():
	pass

