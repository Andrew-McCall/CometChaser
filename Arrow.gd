extends Sprite



var enemy = null
var player = null


func _ready():
	enemy = get_node("../../Enemy")
	player = get_node("../../Player")



func _process(delta):
	
	
	set_rotation(Vector2(player.transform.origin.x,player.transform.origin.y).angle_to(Vector2(enemy.transform.origin.x,enemy.transform.origin.y)))
