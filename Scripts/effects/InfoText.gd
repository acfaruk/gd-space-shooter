extends Node2D

func setup(text, position, color):
	$label.text = text
	self.modulate = color
	self.position = position

func _on_anim_player_animation_finished(_anim_name):
	queue_free()
