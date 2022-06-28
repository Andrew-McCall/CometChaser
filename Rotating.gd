extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var x = 0;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	x += 0.1;
	rotate_x(0.00001);
	rotate_y(0.006);
	rotate_z(0.003);
