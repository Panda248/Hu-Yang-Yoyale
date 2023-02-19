extends StaticBody2D
class_name Crate

export var lootAmount := 3
export var lootDistance := 50
export (PackedScene) var itemScene
signal spawn_item(item)
var canInteract : bool = false

func onready():
	randomize()

func process():
	if(canInteract):
		print("hi")
	pass

func interact():
	for n in lootAmount:
		generate_loot()
	queue_free()

func generate_loot():
	var item = itemScene.instance()
	item.global_position = global_position + Vector2(randf() * (lootDistance*2) - lootDistance, randf() * (lootDistance*2) - lootDistance)
	emit_signal("spawn_item", item)
	pass
