class_name Rock
extends KinematicBody2D

var direction := Vector2.ZERO;
var totalDistanceTraveled = 0
var totalTimeAlive = 0

export (int) var speed = 3;
var penetration = 0;
onready var breakableMap : TileMap = get_node("/root/World/Destructibles")
	
var almostDead = false

func _physics_process(delta: float) -> void:
	totalTimeAlive += 1
	if (totalTimeAlive > 70):
		modulate.a *= 0.9
	#explode()
	if (totalDistanceTraveled >= 150 || totalTimeAlive > 100):
		queue_free()
	if direction != Vector2.ZERO:
		var velocity = direction * speed;
		speed *= 0.98
		#$Explosion/Particles2D.amount = ;
		var collision_info = move_and_collide(velocity);
		if collision_info:
			velocity = velocity.bounce(collision_info.normal)
		totalDistanceTraveled += velocity.length()
	
func set_direction(direction: Vector2):
	self.direction = direction;
	look_at(position+direction)

func explode():
	if (totalTimeAlive > 40 && !almostDead):
		$Explosion/Particles2D.amount += 5
		almostDead = true
	$Explosion.visible = true;

func _on_Rock_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(body == breakableMap):
		var collidedTilePos = breakableMap.world_to_map(global_position)
		var collidedTileIndex = breakableMap.get_cell(collidedTilePos.x, collidedTilePos.y)
		breakableMap.set_cell(collidedTilePos.x, collidedTilePos.y, collidedTileIndex-1)
	if(penetration <= 0):
		queue_free()
