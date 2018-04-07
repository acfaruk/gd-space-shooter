extends CanvasLayer

var health
var energy
var score

func _ready():
	health = find_node("health")
	energy = find_node("energy")
	score = find_node("score")

func set_health(value):
	health.value = value

func get_health():
	return health.value

func set_energy(value):
	energy.value = value

func get_energy():
	return energy.value
	
func set_score(value):
	score.text = str(value)

func get_score():
	return int(score.text)

func _on_player_health_changed(health):
	set_health(health)

func _on_player_energy_changed(energy):
	set_energy(energy)

func _on_player_score_changed(score):
	set_score(score)
