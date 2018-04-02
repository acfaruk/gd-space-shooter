extends RigidBody2D

var speed = Vector2(0, 0)

func _ready():
	speed.x = randi() % 10 - 5
	speed.y = randi() % 10 - 5
	apply_impulse(Vector2(0, 0), speed*75)