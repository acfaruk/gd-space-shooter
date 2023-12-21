extends RigidBody2D

#ENUMS
enum SIZE {BIG, MEDIUM, SMALL}

#SCRIPTS
const Bullet = preload("res://Scripts/Bullet.gd")

#SCENES
@export var medium_meteor_scene: PackedScene
@export var small_meteor_scene: PackedScene
@export var explosion: PackedScene
@export var info_text: PackedScene

#EXPORT
@export var size: SIZE
@export var points: int

#VARS
var speed = Vector2(0, 0)
var meteor_manager = null

func _ready():
	speed.x = randf_range(-10, 10)
	speed.y = randf_range(-10, 10)
	apply_impulse(speed*30)
	apply_torque_impulse(randf())
	contact_monitor = true
	max_contacts_reported = 10

func setup(pos, meteor_mgr, dist = 0):
	self.meteor_manager = meteor_mgr
	self.meteor_manager.add_meteor(self)
	position = pos
	rotation_degrees = randi() % 360
	move_local_y(-dist)

func _on_meteor_body_entered(body):
	if body is Bullet && size == SIZE.BIG:
		explode()
		shatter_to_pieces()
	
	elif body is Bullet:
		explode()

func _create_info(info, color):
	var new_info_text = info_text.instantiate()
	new_info_text.setup(info, position, color)
	get_parent().add_child(new_info_text)
	
func shatter_to_pieces():
	var medium_meteor = medium_meteor_scene.instantiate()
	var medium_meteor2 = medium_meteor_scene.instantiate()
	var small_meteor = small_meteor_scene.instantiate()
	
	var meteors = [medium_meteor, medium_meteor2, small_meteor]
	
	for meteor in meteors:
		meteor.setup(position, meteor_manager)
		get_parent().call_deferred("add_child", meteor)

func destroy():
	meteor_manager.remove_meteor(self)
	queue_free()

func explode():
	get_parent().find_child("player").add_score(points)
	_create_info("+ " + str(points) + "P", Color(0,1,0))
	var new_explosion = explosion.instantiate()
	new_explosion.setup(position)
	get_parent().add_child(new_explosion)
	destroy()
