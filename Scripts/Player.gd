extends Node2D

var bullet_scene = preload("res://Scenes/Bullet.tscn")
var meteor_scene = preload("res://Scenes/Meteor.tscn")

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
		
	if Input.is_action_just_pressed("ui_select"):
		shoot()
		
	if Input.is_action_pressed("ui_up"):
		cur_speed = cur_speed + acceleration if cur_speed < max_speed else cur_speed
		$main_turbine.emitting = true
		if (! $turbine_sound.playing):
			$turbine_sound.play()
	else:
		cur_speed = max(cur_speed - acceleration / 2, 0)
		$main_turbine.emitting = false
		$turbine_sound.stop()
		
	move_local_y(-cur_speed)
	
	spawn_meteors()
	
func shoot():
	var bullet = bullet_scene.instance()
	bullet.position = position
	bullet.rotation = rotation
	bullet.move_local_y(-25)
	get_node("/root/Node").add_child(bullet)
	
func spawn_meteors():
	var meteor = meteor_scene.instance()
	
	var min_distance = 1050
	var dist = randi() % 200 + min_distance
	var rot = randi() % 360
	
	meteor.position = $main_cam.position
	meteor.rotation_degrees = rot
	meteor.move_local_y(-dist)
	print(meteor.position)
	get_node("/root/Node").add_child(meteor)
