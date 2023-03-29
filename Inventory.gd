extends Control

const SlotClass = preload("res://Slot.gd")
onready var inventory_slots = $GridContainer
var holding_item = null
var playerNode 
var attachmentSystem

func set_holding_item(i):
	holding_item = i
	$HoldingItem.texture = i.texture

func _ready():
	playerNode = find_parent("Player")
	attachmentSystem = playerNode.find_node("AttachmentSystem")
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("pressed", self, "pressed", [inv_slot])
		

func _process(delta):
	if(Input.is_action_just_pressed("open_inv")):
		visible = !visible
	if(visible and playerNode.inventory.hotbarArray[playerNode.inventory.equippedIndex]):
		if(playerNode.inventory.hotbarArray[playerNode.inventory.equippedIndex].item_type == "WEAPON"):
			attachmentSystem.visible = true
			attachmentSystem.set_weapon(playerNode.inventory.hotbarArray[playerNode.inventory.equippedIndex])
			attachmentSystem.set_holding_item(holding_item)
	else:
		attachmentSystem.visible = false
		
	if(is_instance_valid(holding_item)):
		$HoldingItem.set_texture(holding_item.find_node("Icon").texture)
		$HoldingItem.set_position(get_global_mouse_position() - $HoldingItem.rect_size/2)
	else:
		$HoldingItem.set_texture(null)

func pressed(slot: SlotClass):
	var slot_index = slot.get_index()
	if is_instance_valid(holding_item):
		if is_instance_valid(slot.item):
			if(holding_item.item_name == slot.item.item_name):
				playerNode.inventory.stack_item(holding_item, slot.item)
			else:
				print("swapped")
				var temp = slot.item
				playerNode.inventory.add_item_at_index(holding_item, slot_index)
				holding_item = temp
				
		else:
			print("?")
			playerNode.inventory.add_item_at_index(holding_item, slot_index)
			holding_item = null
	elif is_instance_valid(slot.item):
		print("...")
		
		holding_item = slot.item
		holding_item.position = get_global_mouse_position()
		slot.remove()
		playerNode.inventory.remove_item_at_index(slot_index)
	pass

func _on_Inventory_update_UI_slot(slot, item):
	$GridContainer.get_child(slot).set_item(item)
	

