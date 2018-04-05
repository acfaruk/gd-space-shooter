extends RigidBody2D

#ENUMS
enum SIZE {BIG, MEDIUM, SMALL}

#SCRIPTS
const Bullet = preload("res://Scripts/Bullet.gd")

#SCENES
const medium_meteor_scene = preload("res://Scenes/meteors/medium_meteor.tscn")
const small_meteor_scene = preload("res://Scenes/meteors/small_meteor.tscn")

#EXPORT
export (SIZE) var size

#VARS
var speed = Vector2(0, 0)
var meteor_manager = null

func _ready():
	speed.x = randi() % 10 - 5
	speed.y = randi() % 10 - 5
	apply_impulse(Vector2(0, 0), speed*75)
	contact_monitor = true
	contacts_reported = 1

func setup(pos, meteor_manager, dist = 0):
	self.meteor_manager = meteor_manager
	self.meteor_manager.add_meteor(self)
	position = pos
	rotation_degrees = randi() % 360
	move_local_y(-dist)

func _on_meteor_body_shape_entered(body_id, body, body_shape, local_shape):
	if body is Bullet && size == SIZE.BIG:
		explode()
		shatter_to_pieces()
	
	elif body is Bullet:
		explode()

func shatter_to_pieces():
	var medium_meteor = medium_meteor_scene.instance()
	var medium_meteor2 = medium_meteor_scene.instance()
	var small_meteor = small_meteor_scene.instance()
	
	var meteors = [medium_meteor, medium_meteor2, small_meteor]
	
	for meteor in meteors:
		meteor.setup(position, meteor_manager)
		get_parent().add_child(meteor)

	
func destroy():
	meteor_manager.remove_meteor(self)
	$sprite.queue_free()
	$shape.queue_free()

func explode():
	destroy()
	$explosion_particles.emitting = true
	$explosion_sound.play()

func _on_explosion_sound_finished():
	queue_free()
