extends Node2D

onready var world = get_node("/root/main")

var bullet_scene = preload("res://Scenes/Bullet.tscn")

export (float) var turn_amount = 0.05
export (float) var max_speed = 4
export (float) var acceleration = 0.1

var cur_speed = 0

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		rotate(turn_amount)
		
	if Input.is_action_pressed("ui_left"):
		rotate(-turn_amount)
		
	if Input.is_action_just_pressed("ui_select"):
		shoot()
		
	if Input.is_action_pressed("ui_up"):
		cur_speed = min(cur_speed + acceleration, max_speed)
		$turbine_particles.emitting = true
		if (! $turbine_sound.playing):
			$turbine_sound.play()
	else:
		cur_speed = max(cur_speed - acceleration / 2, 0)
		$turbine_particles.emitting = false
		$turbine_sound.stop()
		
	move_local_y(-cur_speed)
	
func shoot():
	var bullet = bullet_scene.instance()
	bullet.position = position
	bullet.rotation = rotation
	bullet.move_local_y(-25)
	world.add_child(bullet)
	

