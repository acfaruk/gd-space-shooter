extends Node2D

var speed = Vector2(0, 0)
var rot_speed = 0

func _ready():
	speed.x = randi() % 10 - 5
	speed.y = randi() % 10 - 5
	rot_speed = (randf() - 0.5) / 5

func _physics_process(delta):
	move_local_y(speed.y)
	move_local_x(speed.x)
	$sprite.rotate(rot_speed)