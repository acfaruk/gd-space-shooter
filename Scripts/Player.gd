extends RigidBody2D

#SCRIPTS
const Meteor = preload("res://Scripts/Meteor.gd")
const PickUp = preload("res://Scripts/pickups/PickUp.gd")

#SCENES
export (PackedScene) var bullet_scene
export (PackedScene) var info_text

#EXPORTS
export (float) var speed = 5

signal health_changed(health)
signal energy_changed(energy)
signal score_changed(score)
signal death(final_score)

var dir = Vector2(0, 0)

var health = 100
var energy = 100
var score = 0

var is_energy_reloading = false

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
	
	if is_energy_reloading:
		add_energy(1)
	
func shoot():
	if energy > 0:
		var bullet = bullet_scene.instance()
		bullet.setup(position, rotation, 35)
		get_parent().add_child(bullet)
		is_energy_reloading = false
		add_energy(-5)
	elif !$no_energy_sound.playing:
		$no_energy_sound.play()
	
func start_turbine():
	if ! $turbine_sound.playing:
		$turbine_sound.play()
		$turbine_particles.emitting = true

func stop_turbine():
	if $turbine_sound.playing:
		$turbine_sound.stop()
		$turbine_particles.emitting = false

func add_health(amount):
	health = clamp(health + amount, 0, 100)
	_create_info(str(amount) + "HP", Color(1,0,0) if amount < 0 else Color(0,1,0))
	emit_signal("health_changed", health)
	if health == 0:
		emit_signal("death", score)

func add_energy(amount):
	energy = clamp(energy + amount, 0, 100)
	$energy_timer.start()
	emit_signal("energy_changed", energy)
	
func add_score(amount):
	score = max(0, score + amount)
	emit_signal("score_changed", score)

func _on_player_body_entered(body):
	if body is Meteor && ! $crash_sound.playing:
		$crash_sound.play()
		var crash_velocity = clamp((body.linear_velocity - linear_velocity).length(), 0, 800)/800
		var health_penalty = floor(lerp(0, 30, crash_velocity * body.mass))
		add_health(-health_penalty)
	elif body is PickUp:
		body.pickup(self)

func _on_energy_timer_timeout():
	is_energy_reloading = true

func _create_info(info, color):
	var new_info_text = info_text.instance()
	new_info_text.setup(info, position, color)
	get_parent().add_child(new_info_text)

#GROUP restartable
func restart():
	position = Vector2(0,0)
	add_health(100)
	add_energy(100)
	add_score(-score)
