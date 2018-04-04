extends RigidBody2D

enum SIZE {BIG, MEDIUM, SMALL} 

const Bullet = preload("res://Scripts/Bullet.gd")

const medium_meteor_scene = preload("res://Scenes/meteors/medium_meteor.tscn")
const small_meteor_scene = preload("res://Scenes/meteors/small_meteor.tscn")

var speed = Vector2(0, 0)

export (SIZE) var size

func _ready():
	speed.x = randi() % 10 - 5
	speed.y = randi() % 10 - 5
	apply_impulse(Vector2(0, 0), speed*75)
	contact_monitor = true
	contacts_reported = 1

func _on_meteor_body_shape_entered(body_id, body, body_shape, local_shape):
	if body is Bullet && size == SIZE.BIG:
		destroy()
		shatter_to_pieces()
	
	elif body is Bullet:
		destroy()

func shatter_to_pieces():
	var medium_meteor = medium_meteor_scene.instance()
	var medium_meteor2 = medium_meteor_scene.instance()
	var small_meteor = small_meteor_scene.instance()
	
	var meteors = [medium_meteor, medium_meteor2, small_meteor]
	
	for meteor in meteors:
		meteor.position = position
		MeteorManager.add_meteor(meteor)
		get_parent().add_child(meteor)

func _on_explosion_sound_finished():
	queue_free()
	
func destroy():
	MeteorManager.remove_meteor(self)
	$explosion_particles.emitting = true
	$explosion_sound.play()
	$sprite.queue_free()
	$shape.queue_free()
