extends Node

export (PackedScene) var mob_scene

var spawnRate = 40
var player = null;
var rng = RandomNumberGenerator.new()

var paused = false;

func _ready():
	player = find_node("Player")
	rng.randomize()


func _process(_delta):
	spawnRate -= 0.5
	if (rng.randi()%100 > spawnRate):
		var mob = mob_scene.instance()
		mob.transform.origin = Vector3((rng.randi()%150 - 75)*2, (rng.randi()%150 - 75)*2 , -175) + player.transform.origin
		mob.scale *= 1 + 6*rng.randf() + 6*rng.randf() + 6*rng.randf()
		mob.rotate_z(rng.randf())
		mob.rotate_y(rng.randf())
		mob.rotate_x(rng.randf())
		mob.mass = mob.scale.x
		mob.apply_central_impulse(Vector3(0,0 ,  (70-spawnRate)/4) )
		add_child(mob)

func pause():
	get_tree().paused = !paused
	paused = !paused

