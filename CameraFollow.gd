extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const smooth_speed: int =  24
var target 

const offset = Vector3(0, 4, 6)

func _ready(): 
	target = get_node("../Player")

func _physics_process(delta):
	if(target != null):
		self.transform.origin = lerp(self.transform.origin, target.transform.origin + offset, smooth_speed * delta)
	
	rotation = lerp(rotation, target.rotation * 0.3, smooth_speed / 4 * delta)
