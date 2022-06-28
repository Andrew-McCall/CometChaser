extends Spatial

var rng = RandomNumberGenerator.new()
var player = null

func _ready():
	rng.randomize()
	player = get_node("../Player")

func _physics_process(delta):
	var distance = (transform.origin-player.transform.origin).normalized()
	var move = Vector3((rng.randf()-0.5)*delta*50, (rng.randf()-0.5)*delta*50, 0) + distance*delta*-distance.z*80
	move.z = delta*2
	global_translate(move)
