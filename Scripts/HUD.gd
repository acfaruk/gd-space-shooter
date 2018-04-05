extends CanvasLayer

var health
var energy

func _ready():
	health = find_node("health")
	energy = find_node("energy")

func set_health(value):
	health.value = value

func get_health():
	return health.value

func set_energy(value):
	energy.value = value

func get_energy():
	return energy.value


func _on_player_health_changed(health):
	set_health(health)
