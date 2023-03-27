extends Panel

var ItemClass = preload("res://Item.tscn")
var item = null

func _ready():
	if randi() % 2 == 0:
		item = ItemClass.instance()
		item.canInteract = false
		add_child(item)
		item.global_position = rect_global_position + rect_size*rect_scale/2

func _process(delta):
	pass

func remove():
	print("reoved")
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null

func add(new_item):
	print("sdf")
	item = new_item
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(new_item)
	add_child(item)
	item.global_position = rect_global_position + rect_size*rect_scale/2
