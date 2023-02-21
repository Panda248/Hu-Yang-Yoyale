extends Node2D

const SlotClass = preload("res://Slot.gd")
onready var inventory_slots = $GridContainer
var holding_item = null

func _ready():
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self, "slot_gui_input", [inv_slot])
	

func _process(delta):
	position = get_tree().current_scene.get_node("Player").position
	position += Vector2(30, 30)
	if(is_instance_valid(holding_item)):
		holding_item.global_position = get_global_mouse_position()

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if is_instance_valid(holding_item):
				if !slot.item:
					slot.add(holding_item)
					holding_item = null
				else:
					var temp_item = slot.item
					slot.remove()
					temp_item.global_position = get_global_mouse_position()
					slot.add(holding_item)
					holding_item = temp_item
			elif is_instance_valid(slot.item):
				holding_item = slot.item
				slot.remove()
				holding_item.global_position = get_global_mouse_position()
