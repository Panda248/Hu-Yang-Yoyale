extends KinematicBody2D

signal player_shot(bullet, position, direction);

var direction;
export var health = 10;
export var velocity = 100;

export (PackedScene) var Bullet;


# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(0,0);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Label").text = var2str(health)
	var _motion = Vector2();
	look_at(get_global_mouse_position());
	input_movement()
	input_action()
	direction = direction.normalized();
	_motion = move_and_collide(direction * velocity * delta);
	pass


func input_movement():
	if(Input.is_action_pressed("ui_left")):
		direction.x = -1;
	elif(Input.is_action_pressed("ui_right")):
		direction.x = 1;
	else:
		direction.x = 0;

	if(Input.is_action_pressed("ui_up")):
		direction.y = -1;
	elif(Input.is_action_pressed("ui_down")):
		direction.y = 1;
	else:
		direction.y = 0;

func input_action():
	if Input.is_action_just_pressed("primaryFire"):
		#$Fists.primaryFire();
		$Pistol.primaryFire()
		
		
		pass

func takeDamage(damage : int):
	get_node("damageFlash").play("damageFlash")
	health -= damage
