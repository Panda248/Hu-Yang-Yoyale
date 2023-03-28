extends Control

const SlotClass = preload("res://Slot.gd")
onready var inventory_slots = $GridContainer
var holding_item = null
var playerNode 


func has_item(item) -> bool:
	for slot in $GridContainer.get_children():
		if(!is_instance_valid(slot.item)):
			if(slot.item == item):
				return true
	return false

func _ready():
	playerNode = find_parent("Player")
	
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("pressed", self, "pressed", [inv_slot])
		

func _process(delta):
	if(Input.is_action_just_pressed("open_inv")):
		visible = !visible
	if(is_instance_valid(holding_item)):
		holding_item.global_position = get_global_mouse_position()

func pressed(slot: SlotClass):
	var slot_index = slot.get_index()
	if is_instance_valid(holding_item):
		if is_instance_valid(slot.item):
			playerNode.inventory.stack_item(holding_item, slot.item)
		else:
			print("?")
			playerNode.inventory.add_item_at_index(holding_item, slot_index)
			holding_item = null
	elif is_instance_valid(slot.item):
		print("...")
		
		holding_item = slot.item
		holding_item.position = get_global_mouse_position()
		slot.remove()
	pass

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event.pressed:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT:
				if is_instance_valid(holding_item):
					if is_instance_valid(slot.item):
						playerNode.inventory.stack_items(holding_item, slot.item)
					else:
						print("?")
						slot.add(holding_item)
						holding_item = null
				elif is_instance_valid(slot.item):
					print("...")
					
					holding_item = slot.item
					holding_item.position = get_global_mouse_position()
					slot.remove()

func _on_Inventory_update_UI_slot(slot, item):
	$GridContainer.get_child(slot).item = item

