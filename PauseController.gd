extends Node

var pressed = false

export (PackedScene) var start_scene
var player = null

func _ready():
	player = get_node("../Player")

func _process(delta):
	if (Input.is_key_pressed(KEY_P)):
		if (!pressed):
			get_parent().pause()
		pressed = true
	else:
		pressed = false
	
	if get_parent().paused:
		if (Input.is_key_pressed(KEY_R) || Input.is_key_pressed(KEY_SPACE)):
			if player.shieldFloat <= 0 || player.distance <= 1 || player.distance >= 6000:
				get_tree().reload_current_scene()
				get_parent().pause()
