extends RigidBody2D

#EXPORTS
export (float) var speed = 10.0

func _ready():
	contact_monitor = true
	contacts_reported = 1

func setup(pos, rot = 0, dist = 0):
	position = pos
	rotation = rot
	move_local_y(-dist)

func _physics_process(delta):
	move_local_y(-speed)

func _on_timer_timeout():
	queue_free()

func _on_player_bullet_body_shape_entered(body_id, body, body_shape, local_shape):
	queue_free()
