extends RigidBody

var impact = false
var shield = 1

var hue = null

func _ready():
	hue = get_child(0).get_surface_material(0)
	
func _physics_process(_delta):
	if (get_transform().origin.z> 25):
		self.queue_free()
		
	if (get_linear_velocity().x != 0):
		set_collision_layer_bit(1, true)
		apply_central_impulse(Vector3(0,0, 10))
	
	if impact and shield > 0:
		hue.emission_energy = shield
		shield -= 0.08

func _on_RigidBody_body_entered(body):
	if (!impact && body.name == "Player"):
		impact = true
		body.hit(mass, get_linear_velocity().length_squared()/1000)
		hue = hue.duplicate()
		get_child(0).set_material_override(hue)
		hue.emission_energy = 0.6
