extends RigidBody2D

const Bullet = preload("res://Scripts/Bullet.gd")

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
	print(body)
	if body is Bullet:
		destroy()

func destroy():
	queue_free()
