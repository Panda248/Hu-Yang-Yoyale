extends Control

var holding_item
onready var inventory = find_parent("Player").get_node("Inventory")
func _process(delta):
	pass
func set_holding_item(i):
	holding_item = i

func _on_HelmetBut_pressed():
	if(holding_item):
		print("DFDSJF")
		if(holding_item.item_type == "ARMOUR"):
			print("DFKE")
			if(holding_item.get_type() == "HEAD"):
				inventory.add_gear(holding_item)
				find_parent("Player").get_node("UI/Inventory").set_holding_item(null)
				$HelmetBut.set_item(holding_item)
	else:
		if($HelmetBut.item):
			holding_item = $HelmetBut.item
			inventory.remove_gear(holding_item)
			$HelmetBut.remove()
			find_parent("Player").get_node("UI/Inventory").set_holding_item(holding_item)
	pass # Replace with function body.


func _on_VestBut_pressed():
	if(holding_item):
		if(holding_item.item_type == "ARMOUR"):
			if(holding_item.get_type() == "CHEST"):
				inventory.add_gear(holding_item)
				find_parent("Player").get_node("UI/Inventory").set_holding_item(null)
				$VestBut.set_item(holding_item)
	else:
		if($VestBut.item):
			holding_item = $VestBut.item
			inventory.remove_gear(holding_item)
			$VestBut.remove()
			find_parent("Player").get_node("UI/Inventory").set_holding_item(holding_item)
	pass # Replace with function body.
