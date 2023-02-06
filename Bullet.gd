extends Area2D

var direction := Vector2.ZERO;

export (int) var speed = 15;

func _on_Bullet_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	queue_free()

func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * speed;
		global_position += velocity;
	
func set_direction(direction: Vector2):
	self.direction = direction;
	
