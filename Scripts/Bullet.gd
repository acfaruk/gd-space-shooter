extends RigidBody2D

#SCRIPTS
const PickUp = preload("res://Scripts/pickups/PickUp.gd")

#EXPORTS
@export var speed: float = 10.0

func _ready():
	contact_monitor = true
	max_contacts_reported = 1

func setup(pos, rot = 0, dist = 0):
	position = pos
	rotation = rot
	move_local_y(-dist)

func _physics_process(_delta):
	move_local_y(-speed)

func _on_timer_timeout():
	queue_free()

func _on_player_bullet_body_shape_entered(_body_id, _body, _body_shape, _local_shape):
	if (! _body is PickUp):
		$collision_shape.queue_free()
		$sprite.queue_free()
		$light.queue_free()
