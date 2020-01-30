extends StaticBody2D

func setup(position):
	self.position = position

func pickup(player):
	$sound.play()
	$sprite.hide()
	pickup_specific(player)
	
func pickup_specific(_player):
	pass

func _on_sound_finished():
	queue_free()

func _on_life_timer_timeout():
	queue_free()

# restartable group
func restart():
	queue_free()
