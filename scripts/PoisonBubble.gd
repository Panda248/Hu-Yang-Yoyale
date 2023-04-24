class_name PoisonBubble
extends KinematicBody2D

var direction := Vector2.ZERO;
var totalDistanceTraveled = 0
var totalTimeAlive = 0

export (int) var speed = 1;
var penetration = 0;
onready var breakableMap : TileMap = get_node("/root/World/Destructibles")
	
var almostDead = false

func _physics_process(delta: float) -> void:
	totalTimeAlive += 1
	if (totalDistanceTraveled >= 1500 || totalTimeAlive > 300):
		queue_free()
	if (totalTimeAlive > 230):
		modulate.a *= 0.9
	if direction != Vector2.ZERO:
		var velocity = direction * speed;
		speed *= 0.99
		#$Explosion/Particles2D.amount = ;
		var collision_info = move_and_collide(velocity);
		if collision_info:
			if (collision_info.get_collider() == find_parent("World").find_node("Player")):
				find_parent("World").find_node("Player").poisonFX()
			speed = 0
			totalTimeAlive = 300
			velocity = velocity.bounce(collision_info.normal)
		totalDistanceTraveled += velocity.length()
	
func set_direction(direction: Vector2):
	self.direction = direction;
	look_at(position+direction)

func _on_Rock_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(body == breakableMap):
		var collidedTilePos = breakableMap.world_to_map(global_position)
		var collidedTileIndex = breakableMap.get_cell(collidedTilePos.x, collidedTilePos.y)
		breakableMap.set_cell(collidedTilePos.x, collidedTilePos.y, collidedTileIndex-1)
	if(penetration <= 0):
		queue_free()
