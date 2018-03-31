extends Node2D

export (float) var speed = 10.0

func _ready():
	move_local_y(-10)
	visible = true

func _physics_process(delta):
	move_local_y(-speed)

func _on_Timer_timeout():
	queue_free()
