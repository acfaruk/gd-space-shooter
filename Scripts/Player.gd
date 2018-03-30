extends Node2D

export (float) var turn_amount = 0.05
export (float) var max_speed = 4
export (float) var acceleration = 0.1

var cur_speed = 0

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		rotate(turn_amount)
	if Input.is_action_pressed("ui_left"):
		rotate(-turn_amount)
	if Input.is_action_pressed("ui_up"):
		cur_speed = cur_speed + acceleration if cur_speed < max_speed else cur_speed
	else:
		cur_speed = cur_speed - acceleration if cur_speed > 0 else 0
		
	move_local_y(-cur_speed)
	pass