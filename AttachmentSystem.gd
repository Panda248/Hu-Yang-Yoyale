extends Control
var weapon
var holding_item
func _process(delta):
	pass

func set_weapon(w):
	weapon = w
	$Weapon/TextureRect.set_texture(w.find_node("Icon").texture)
	$ScopeBut.remove()
	$SuppressBut.remove()
	for attachment in w.get_attachments():
		if(attachment.item_name == "SCOPE"):
			$ScopeBut.set_item(attachment)
		elif(attachment.item_name == "SUPPRESSOR"):
			$SuppressBut.set_item(attachment)

func set_holding_item(i):
	holding_item = i

func _on_ScopeBut_pressed():
	if(holding_item):
		if(holding_item.item_name == "SCOPE"):
			weapon.add_attachment(holding_item)
			find_parent("Player").get_node("UI/Inventory").set_holding_item(null)
			$ScopeBut.set_item(holding_item)
	else:
		if($ScopeBut.item):
			$ScopeBut.item.reset(weapon)
			holding_item = $ScopeBut.item
			$ScopeBut.remove()
			find_parent("Player").get_node("UI/Inventory").set_holding_item(holding_item)



func _on_SuppressBut_pressed():
	if(holding_item):
		if(holding_item.item_name == "SUPPRESSOR"):
			weapon.add_attachment(holding_item)
			find_parent("Player").get_node("UI/Inventory").set_holding_item(null)
			$SuppressBut.set_item(holding_item)
	else:
		if($SuppressBut.item):
			$SuppressBut.item.reset(weapon)
			holding_item = $SuppressBut.item
			$SuppressBut.remove()
			find_parent("Player").get_node("UI/Inventory").set_holding_item(holding_item)

