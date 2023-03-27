extends Control

const SlotClass = preload("res://scripts/Slot.gd")
onready var inventory_slots = $GridContainer
var holding_item = null

func _ready():
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self, "slot_gui_input", [inv_slot])
	

func _process(delta):
	if(Input.is_action_just_pressed("open_inv")):
		visible = !visible
	if(is_instance_valid(holding_item)):
		holding_item.global_position = get_global_mouse_position()

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if is_instance_valid(holding_item):
				if is_instance_valid(slot.item):
					var stack_size = 99
					var addable = stack_size - slot.item.item_quantity
					if addable >= holding_item.item_quantity:
						slot.item.add_items(holding_item.item_quantity)
						holding_item.queue_free()
						holding_item = null
					else:
						slot.item.add_items(addable)
						holding_item.remove_items(addable)
				else:
					print("?")
					slot.add(holding_item)
					holding_item = null
			elif is_instance_valid(slot.item):
				print("...")
				
				holding_item = slot.item
				holding_item.position = get_global_mouse_position()
				slot.remove()
