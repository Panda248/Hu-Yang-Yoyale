extends Panel

var ItemClass = preload("res://Item.tscn")
var item = null

func _ready():
	if randi() % 2 == 0:
		item = ItemClass.instance()
		add_child(item)

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
	var itemParent = item.get_parent()
	item.position = rect_position + ((rect_size)/2)
