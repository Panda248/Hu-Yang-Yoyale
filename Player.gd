extends KinematicBody2D

signal player_shot(bullet, position, direction);

var direction;

export var velocity = 100;
export (PackedScene) var Bullet;

onready var end_of_barrel = $BarrelEnd;

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(0,0);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var _motion = Vector2();
	look_at(get_global_mouse_position());
	input_movement()
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

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("primaryFire"):
		shoot();

func shoot():
	var bullet_instance = Bullet.instance();
	var target = get_global_mouse_position();
	var direction_to_mouse = end_of_barrel.global_position.direction_to(target).normalized();

	emit_signal("player_shot", bullet_instance, end_of_barrel.global_position, direction_to_mouse);
	
							
