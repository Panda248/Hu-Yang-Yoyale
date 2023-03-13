extends StaticBody2D
class_name Crate

onready var ItemManager = get_node("%ItemManager")
export var lootDistance := 50
export (Array, PackedScene) var itemScenes
signal spawn_item(item)
var canInteract : bool = false

func onready():
	var connectSuccess = connect("spawn_item", ItemManager, "spawn_item")
	print(var2str(connectSuccess))
	randomize()

func interact():
	for scene in itemScenes:
		generate_loot(scene)
	queue_free()

func generate_loot(lootScene : PackedScene):
	print("hello")
	var item = lootScene.instance()
	item.global_position = global_position + Vector2(randf() * (lootDistance*2) - lootDistance, randf() * (lootDistance*2) - lootDistance)
	emit_signal("spawn_item", item)
	pass
