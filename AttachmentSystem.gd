extends Control
var weapon
var holding_item
func _process(delta):
	pass

func set_weapon(w):
	weapon = w
	$Weapon/TextureRect.set_texture(w.find_node("Icon").texture)

func set_holding_item(i):
	holding_item = i

func _on_ScopeBut_pressed():
	if(holding_item.typeName == "scope"):
		weapon.add_attachment(holding_item)
		find_parent("Player").get_node("UI/Inventory").set_holding_item(null)
	pass # Replace with function body.


func _on_SuppressBut_pressed():
	if(holding_item.typeName == "suppressor"):
		weapon.add_attachment(holding_item)
		find_parent("Player").get_node("UI/Inventory").set_holding_item(null)
	pass # Replace with function body.
