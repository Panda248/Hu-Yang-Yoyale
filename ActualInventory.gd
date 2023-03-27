extends Node2D

var inventory = {
	#slot index : itemObject
}
onready var inventoryUI = get_parent().get_node("UI/Inventory")

func add_item_to_inventory(item) -> bool:
	for slot in inventoryUI.get_node("GridContainer").get_children():
		if(slot.item == item):
			slot.add(item)
			return true
		if(!is_instance_valid(slot.item)):
			if(slot.has_method("add")):
				slot.add(item)
				return true
	return false
