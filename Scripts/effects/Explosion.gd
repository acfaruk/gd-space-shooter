extends Node2D

func setup(pos, emitting=true):
	position = pos
	$explosion_particles.emitting = emitting

func _on_explosion_sound_finished():
	queue_free()
