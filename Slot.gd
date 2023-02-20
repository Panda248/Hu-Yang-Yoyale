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
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null

func add(new_item):
	item = new_item
	item.position = rect_position + ((rect_size)/2)
	item.position.x += rect_size.x/4
	var inventoryNode = find_parent("Inventory")
	add_child(item)
