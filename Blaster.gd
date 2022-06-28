extends RigidBody

export (PackedScene) var expolsion

var speed = Vector2(0,0)

func _enter_tree():
	set_linear_velocity(global_transform.basis.orthonormalized().xform(Vector3(speed.x, speed.y,-80)))


func _on_Blaster_body_entered(body):
	if (body.name == "Enemy"):
		print("win")
	var explode = expolsion.instance()
	explode.transform.origin = transform.origin 
	explode.emitting = true
	get_parent().add_child(explode)
	self.queue_free()

func ship_speed(ship_vel):
	speed = ship_vel
