extends RigidBody2D

#SCRIPTS
const Meteor = preload("res://Scripts/Meteor.gd")

#SCENES
const bullet_scene = preload("res://Scenes/player_bullet.tscn")

#EXPORTS
export (NodePath) var hud_path
export (float) var speed = 5

#NODES
onready var hud = get_node(hud_path)

var dir = Vector2(0, 0)
var health = 100

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
	
	if dir.length() > 0:
		start_turbine()
	else:
		stop_turbine()
	
	position += dir.normalized() * speed
	
func shoot():
	var bullet = bullet_scene.instance()
	bullet.setup(position, rotation, 35)
	get_parent().add_child(bullet)
	
func start_turbine():
	if ! $turbine_sound.playing:
		$turbine_sound.play()
		$turbine_particles.emitting = true

func stop_turbine():
	if $turbine_sound.playing:
		$turbine_sound.stop()
		$turbine_particles.emitting = false

func lose_health(amount):
	health -= amount
	hud.set_health(health)

func _on_player_body_entered(body):
	if body is Meteor && ! $crash_sound.playing:
		$crash_sound.play()
		var crash_velocity = clamp((body.linear_velocity - linear_velocity).length(), 0, 800)/800
		var health_penalty = floor(lerp(0, 30, crash_velocity * body.mass))
		lose_health(health_penalty)