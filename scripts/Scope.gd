extends Item

onready var zoomValue;

func _ready():
	._ready()
	item_name = "SCOPE"
	item_type = "ATTACHMENT"
	zoomValue = 0.5;

func pick_up(player: Player):
	.pick_up(player)
	monitorable = false
	monitoring = false
	$Icon.visible = false
	$Quantity.visible = false
	$Sprite.visible = true

func attachmentModifier(weapon):
	find_parent("Player").setZoom(zoomValue);
	global_position = get_parent().global_position + (Vector2.RIGHT*5)
func reset():
	find_parent("Player").resetZoom()
