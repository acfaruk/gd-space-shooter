extends CanvasLayer

func set_health(value):
	$container/hbox_main/vbox_left/health.value = value

func get_health():
	return $container/hbox_main/vbox_left/health.value

func set_energy(value):
	$container/hbox_main/vbox_left/energy.value = value

func get_energy():
	return $container/hbox_main/vbox_left/energy.value