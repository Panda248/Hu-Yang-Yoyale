extends Control

var equippedIndex = 0

func _process(delta):
	$GridContainer.get_child(equippedIndex).flat = false
	pass

func _on_Inventory_update_Hotbar_slot(slot, item):
	$GridContainer.get_child(slot).set_item(item)
	pass # Replace with function body.


func _on_Inventory_update_Hotbar_equipped(index):
	equippedIndex = index
	for node in $GridContainer.get_children():
		if node is Button:
			node.flat = true
	pass # Replace with function body.
