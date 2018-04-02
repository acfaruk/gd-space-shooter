extends Node2D

export (float) var speed = 10.0

func _physics_process(delta):
	move_local_y(-speed)

func _on_timer_timeout():
	queue_free()
