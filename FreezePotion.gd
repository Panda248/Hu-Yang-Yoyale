extends Weapon

export (PackedScene) var potion

func _ready():
	attachment_blacklist = ["SCOPE", "SUPPRESSOR"]

func input_action():
	if Input.is_action_just_pressed("game_primary_fire"):
		primaryFire()

func primaryFire():
	var direction = global_position.direction_to(get_global_mouse_position())
	direction = direction.normalized()
	var projectile = potion.instance()
	projectile.direction = direction
	projectile.global_position = global_position + Vector2.UP.rotated(global_rotation)*50
	find_parent("Player").emit_signal("player_project", projectile)
	find_parent("Inventory").remove_item(get_parent())
	pass
