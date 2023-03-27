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
		inv_slot.connect("gui_input", self, "slot_gui_input", [inv_slot])
		

func update_inventory():
	pass


func drop_holding_item():
	if(is_instance_valid(holding_item)):
		
		holding_item.global_position = find_parent("Player").global_position
		holding_item.get_parent().remove_child(holding_item)
		find_parent("World").spawn_item(holding_item)

func drop_inventory_slot_item(slot):
		var item = slot.item
		slot.remove()
		item.global_position = find_parent("Player").global_position
		find_parent("World").spawn_item(item)


func _process(delta):
	if(Input.is_action_just_pressed("open_inv")):
		visible = !visible
	if(is_instance_valid(holding_item)):
		holding_item.global_position = get_global_mouse_position()
	if(Input.is_action_just_pressed("game_primary_fire")):
		drop_holding_item()

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if is_instance_valid(holding_item):
				if is_instance_valid(slot.item):
					stack_items(holding_item, slot.item)
				else:
					print("?")
					slot.add(holding_item)
					holding_item = null
			elif is_instance_valid(slot.item):
				print("...")
				
				holding_item = slot.item
				holding_item.position = get_global_mouse_position()
				slot.remove()
	elif event is InputEventKey:
		print ("oie")
		if event.pressed && event.keycode == KEY_G:
			print("nei nie")
			drop_inventory_slot_item(slot)
			
func stack_items(stacker, stackee):
	var stack_size = 99
	var addable = stack_size - stackee.item_quantity
	if addable >= stacker.item_quantity:
		stackee.add_items(stacker.item_quantity)
		stacker.queue_free()
		stacker = null
	else:
		stackee.add_items(addable)
		stacker.remove_items(addable)
