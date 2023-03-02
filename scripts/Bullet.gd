extends Area2D

var direction := Vector2.ZERO;

export (int) var speed = 15;
var penetration = 0;
onready var breakableMap : TileMap = get_node("/root/World/Destructibles")


func _on_Bullet_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	if(body == breakableMap):
		var collidedTilePos = breakableMap.world_to_map(global_position)
		var collidedTileIndex = breakableMap.get_cell(collidedTilePos.x, collidedTilePos.y)
		breakableMap.set_cell(collidedTilePos.x, collidedTilePos.y, collidedTileIndex-1)
	if(penetration <= 0):
		queue_free()
	

func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * speed;
		global_position += velocity;
	
func set_direction(direction: Vector2):
	self.direction = direction;
	look_at(position+direction)
	
