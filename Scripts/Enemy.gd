extends RigidBody2D

const Bullet = preload("res://Scripts/Bullet.gd")
const Player = preload("res://Scripts/Player.gd")

export (PackedScene) var explosion

export (float) var speed

var player

func _ready():
	player = get_parent().find_node("player")
	contact_monitor = true
	contacts_reported = 10

func setup(pos, dist = 1000):
	position = pos
	rotation_degrees = randi() % 360
	move_local_y(-dist)

func _physics_process(delta):
	look_at(player.position)
	rotate(PI/2)
	move_local_y(-speed)

func _on_enemy_body_entered(body):
	if body is Bullet:
		player.add_score(10)
		destroy()
	if body is Player:
		player.add_health(-10)
		destroy()

func destroy():
	var new_explosion = explosion.instance()
	new_explosion.setup(position)
	get_parent().add_child(new_explosion)
	queue_free()
