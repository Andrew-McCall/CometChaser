extends KinematicBody

var weaponBar = null;
var weaponFloat = 10.0
var shieldBar = null;
var shieldFloat = 90.0

var gameOver = null

export (PackedScene) var blaster

var enemy = null;
var distanceLabel = null
var distanceText = 9999;
var distance = 9999;

var space = false;


func _ready():
	enemy = get_node("../Enemy")
	shieldBar = get_node("../UI/ShieldProgress")
	weaponBar = get_node("../UI/WeaponProgress")
	distanceLabel = get_node("../UI/Score")
	gameOver = get_node("../UI/Instruct")
	distanceText = str(round(self.transform.origin.distance_to(enemy.transform.origin)*10))
	
func _process(_delta):
	weaponBar.value = weaponFloat
	shieldBar.value = shieldFloat
	
	distanceLabel.text = distanceText

func _physics_process(delta):
	weaponFloat += delta + weaponFloat*delta/3
	shieldFloat += shieldFloat*delta/10
	
	if (Input.is_action_pressed("ui_accept") or Input.is_key_pressed(KEY_SPACE)) :
		if (!space and weaponFloat >= 30):
			weaponFloat -= 30
			var shot = blaster.instance()
			shot.transform = transform
			shot.get_child(0).ship_speed(Vector2(60*-rotation.z, 60*rotation.x))
			shot.get_child(1).ship_speed(Vector2(60*-rotation.z, 60*rotation.x))
			get_parent().add_child(shot)
			
		space = true
	else:
		space = false

	# Movement
	var speed = 4.5*delta
	 
	if (Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A)):
		rotation.z += speed
	
	if (Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D)):
		rotation.z -= speed
		
	if (Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S))and rotation.x<2:
		rotation.x += speed
		
	if (Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W)) and rotation.x>-2:
		rotation.x -= speed
		
	rotation.z*=0.90
	rotation.x*=0.90
	global_translate(Vector3(80*-rotation.z*delta, 80*rotation.x*delta, 0))
	
	if weaponFloat > 100:
		weaponFloat = 100
	if shieldFloat > 100:
		shieldFloat = 100
		
	distance = transform.origin.distance_squared_to(enemy.transform.origin)/10
	distanceText = str(round(distance))
	if distance <= 1:
		gameOver.visible = true
		gameOver.text = "You Win!"
		get_parent().pause()
		
	if distance > 6000:
		gameOver.visible = true
		gameOver.text = "You lost the target!"
		get_parent().pause()
	
	if shieldFloat <= 0:
		get_parent().pause()
		gameOver.visible = true
		gameOver.text = "You Died!"


func hit(scale, speed):
	var damage = speed * scale * scale/4
	shieldFloat -= damage
	enemy.global_translate(Vector3(0,0, -damage/4))
