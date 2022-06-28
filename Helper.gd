extends Spatial

var target = null

func _ready():
	target = get_node("../../Enemy")

func _process(delta):
	look_at(target.transform.origin, Vector3(0,10,0))
