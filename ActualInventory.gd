extends Node2D


export var rows = 3
export var cols = 3
var equippedIndex = 0
var size = rows*cols
var inventoryGridArray = [];
var hotbarArray = []
onready var hotbar = $Hotbar
onready var equipped = $Equipped
onready var inventoryUI = get_parent().get_node("UI/Inventory")
signal update_UI_slot(slot, item)
signal update_Hotbar_slot(slot, item)
signal update_Hotbar_equipped(index)


func _ready():
	inventoryGridArray.resize(size)
	hotbarArray.resize(cols)

func add_item(item):
	for i in range(size):
		if(!inventoryGridArray[i]):
			add_item_at_index(item, i)
			return

func add_item_at_index(item, index):
	if(index_in_hotbar(index)):
		print("hotbar")
		add_item_to_hotbar_index(item, index-(cols*(rows-1)))
	inventoryGridArray[index] = item
	emit_signal("update_UI_slot", index ,item)
	print(var2str(index) + var2str(item.item_name) + var2str(item.item_quantity))

func remove_item(item):
	var index = inventoryGridArray.find(item)
	remove_item_at_index(index)
	pass
	
func remove_item_at_index(index):
	if(index_in_hotbar(index)):
		remove_index_from_hotbar(index-(cols*(rows-1)))
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
		if item.item_name == inventoryGridArray[slot_index].item_name:
			stack_item(item, inventoryGridArray[slot_index])
	else:
		remove_item(item)
		inventoryGridArray[slot_index] = item
	pass

func move_slot(slot_index, target_index):
	move_item(inventoryGridArray[slot_index], target_index)

func swap_weapon_left() -> void:
	if(equippedIndex == 0):
		equippedIndex = cols-1
	else:
		equippedIndex-=1
	equip(equippedIndex)
	

func swap_weapon_right() -> void:
	if(equippedIndex == cols-1):
		equippedIndex = 0
	else:
		equippedIndex+=1
	equip(equippedIndex)

func equip(index):
	if(hotbarArray[index]):
		var prevWeapon = equipped.get_child(0)
		equipped.remove_child(prevWeapon)
		hotbar.add_child(prevWeapon)
		var nextWeapon = hotbarArray[index]
		hotbar.remove_child(nextWeapon)
		equipped.add_child(nextWeapon)
		if(hotbarArray[index].item_type == "WEAPON"):
			find_parent("Player").equippedWeapon = nextWeapon.weaponInstance
			nextWeapon.set_global_position(get_parent().global_position + Vector2.DOWN*get_parent().weaponOffset)
			nextWeapon.apply_attachments()
		elif(hotbarArray[index].item_type == "CONSUMABLE"):
			find_parent("Player").equippedWeapon = nextWeapon
		else:
			equipFists()
	else:
		equipFists()
	emit_signal("update_Hotbar_equipped", index)

func equipFists():
	if(is_instance_valid(get_node("Hotbar/Fists"))):
		var fists = get_node("Hotbar/Fists")
		var prevWeapon = equipped.get_child(0)
		hotbar.remove_child(fists)
		equipped.add_child(fists)
		equipped.remove_child(prevWeapon)
		hotbar.add_child(prevWeapon)
	find_parent("Player").resetZoom()
	get_parent().equippedWeapon = equipped.get_child(0)

func get_hotbar() -> Array:
	var weaponArr = hotbar.get_children()
	weaponArr += equipped.get_children()
	return weaponArr

func add_item_to_hotbar(item):
	for i in range(cols):
		if(!hotbarArray[i]):
			add_item_to_hotbar_index(item, i)
			
			return

func add_item_to_hotbar_index(item, index):
	hotbar.add_child(item)
	hotbar.move_child(item, index)
	hotbarArray[index] = item
	emit_signal("update_Hotbar_slot", index, item)
	if equippedIndex == index:
		equip(index)
	pass

func remove_index_from_hotbar(index):
	if(index == equippedIndex):
		equipFists()
	else:
		hotbar.remove_child(hotbarArray[index])
	hotbarArray[index] = null
	emit_signal("update_Hotbar_slot", index, null)

func refill_ammo(weapon, ammo):
	if(weapon.weaponInstance.ammo_type == ammo.item_name):
		weapon.weaponInstance.add_mags(ammo.item_quantity)
		ammo = null

func index_in_hotbar(index) -> bool:
	return index+1 > cols*(rows-1)
