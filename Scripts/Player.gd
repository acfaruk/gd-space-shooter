extends KinematicBody2D

#SCENES
const bullet_scene = preload("res://Scenes/player_bullet.tscn")

#EXPORTS
export (NodePath) var world_path
export (float) var speed = 250

#NODES
onready var world = get_node(world_path)

var dir = Vector2(0, 0)

func _physics_process(delta):
	
	look_at(get_global_mouse_position())
	rotate(PI/2)
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	dir.x = 0; dir.y = 0
	
	if Input.is_action_pressed("up"):
		dir.y = -1
	if Input.is_action_pressed("down"):
		dir.y = 1
	if Input.is_action_pressed("right"):
		dir.x = 1
	if Input.is_action_pressed("left"):
		dir.x = -1
	
	move_and_slide(dir.normalized() * speed)
	
	if dir.length() > 0:
		start_turbine()
	else:
		stop_turbine()
	
func shoot():
	var bullet = bullet_scene.instance()
	bullet.setup(position, rotation, 35)
	world.add_child(bullet)
	
func start_turbine():
	if ! $turbine_sound.playing:
		$turbine_sound.play()
		$turbine_particles.emitting = true

func stop_turbine():
	if $turbine_sound.playing:
		$turbine_sound.stop()
		$turbine_particles.emitting = false