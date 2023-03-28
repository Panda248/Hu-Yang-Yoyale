extends Node2D


export var rows = 3
export var cols = 3
var size = rows*cols
var inventoryGridArray = [];
onready var hotbar = $Hotbar
onready var equipped = $Equipped
onready var inventoryUI = get_parent().get_node("UI/Inventory")
signal update_UI_slot(slot, item)

func _ready():
	inventoryGridArray.resize(size)

func add_item(item):
	for i in range(size):
		if(!inventoryGridArray[i]):
			add_item_at_index(item, i)
			return

func add_item_at_index(item, index):
	inventoryGridArray[index] = item
	emit_signal("update_UI_slot", index ,item)
	print(var2str(index) + var2str(item.item_name) + var2str(item.item_quantity))

func remove_item(item):
	var index = inventoryGridArray.find(item)
	remove_item_at_index(index)
	pass
	
func remove_item_at_index(index):
	inventoryGridArray[index] = null
	emit_signal("update_UI_slot", index, null)
	
func stack_item(stacker, stackee):
	var stack_size = 99
	var addable = stack_size - stackee.item_quantity
	if addable >= stacker.item_quantity:
		stackee.add_items(stacker.item_quantity)
		stacker.queue_free()
		stacker = null
	else:
		stackee.add_items(addable)
		stacker.remove_items(addable)
	emit_signal("update_UI_slot", inventoryGridArray.find(stackee),stackee)
	emit_signal("update_UI_slot", inventoryGridArray.find(stacker),stacker)
	pass
func stack_item_by_index(stackerIndex, stackeeIndex):
	stack_item(inventoryGridArray[stackerIndex], inventoryGridArray[stackeeIndex])

func move_item(item, slot_index):
	if(slot_index):
		if item.itemName == inventoryGridArray[slot_index].itemName:
			stack_item(item, inventoryGridArray[slot_index])
	else:
		remove_item(item)
		inventoryGridArray[slot_index] = item
	pass

func move_slot(slot_index, target_index):
	move_item(inventoryGridArray[slot_index], target_index)

func swap_weapon_left() -> void:
	if(hotbar.get_child_count() > 0):
			var nextWeapon = hotbar.get_child(0)
			var prevWeapon = equipped.get_child(0)
			equipped.remove_child(prevWeapon)
			hotbar.add_child(prevWeapon)
			hotbar.remove_child(nextWeapon)
			equipped.add_child(nextWeapon)
			prevWeapon.set_owner(self)
			nextWeapon.set_owner(self)

func swap_weapon_right() -> void:
	if(hotbar.get_child_count() > 0):
			var nextWeapon = hotbar.get_child(hotbar.get_child_count()-1)
			var prevWeapon = equipped.get_child(0)
			equipped.remove_child(prevWeapon)
			hotbar.add_child(prevWeapon)
			hotbar.remove_child(nextWeapon)
			hotbar.move_child(prevWeapon, 0)
			equipped.add_child(nextWeapon)
			prevWeapon.set_owner(self)
			nextWeapon.set_owner(self)

func get_hotbar() -> Array:
	var weaponArr = hotbar.get_children()
	weaponArr += equipped.get_children()
	return weaponArr

