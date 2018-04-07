extends RigidBody2D

#SCRIPTS
const Meteor = preload("res://Scripts/Meteor.gd")

#SCENES
const bullet_scene = preload("res://Scenes/player_bullet.tscn")
const game_over_scene = preload("res://Scenes/gui/game_over.tscn")

#EXPORTS
export (float) var speed = 5

signal health_changed(health)
signal energy_changed(energy)
signal score_changed(score)

var dir = Vector2(0, 0)

var health = 100
var energy = 100
var score = 0

var is_energy_reloading = false
var is_game_over = false

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
	
	if is_game_over:
		get_tree().paused = true
		var game_over = game_over_scene.instance()
		game_over.setup(score)
		get_parent().add_child(game_over)
		
func shoot():
	if energy > 0:
		var bullet = bullet_scene.instance()
		bullet.setup(position, rotation, 35)
		get_parent().add_child(bullet)
		is_energy_reloading = false
		add_energy(-5)
	
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
	if health == 0:
		is_game_over = true
	emit_signal("health_changed", health)

func add_energy(amount):
	energy = clamp(energy + amount, 0, 100)
	$energy_timer.start()
	emit_signal("energy_changed", energy)
	
func add_score(amount):
	score = max(0, score + amount)
	emit_signal("score_changed", score)

func respawn():
	position = Vector2(0,0)
	add_health(100)
	add_energy(100)
	add_score(-score)
	is_game_over = false
	get_tree().paused = false
	
func _on_player_body_entered(body):
	if body is Meteor && ! $crash_sound.playing:
		$crash_sound.play()
		var crash_velocity = clamp((body.linear_velocity - linear_velocity).length(), 0, 800)/800
		var health_penalty = floor(lerp(0, 30, crash_velocity * body.mass))
		add_health(-health_penalty)

func _on_energy_timer_timeout():
	is_energy_reloading = true
