extends RigidBody2D

const Bullet = preload("res://Scripts/Bullet.gd")
const Player = preload("res://Scripts/Player.gd")

export (PackedScene) var explosion
export (PackedScene) var info_text

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
		_create_info("+ 10P", Color(0,1,0))
		destroy()
	if body is Player:
		player.add_health(-10)
		_create_info("- 10HP", Color(1,0,0))
		destroy()

func _create_info(info, color):
	var new_info_text = info_text.instance()
	new_info_text.setup(info, position, color)
	get_parent().add_child(new_info_text)

func destroy():
	var new_explosion = explosion.instance()
	new_explosion.setup(position)
	get_parent().add_child(new_explosion)
	queue_free()
