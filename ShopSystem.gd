extends Control

var fleshCount
var player 

var health = preload("res://HealthPotion.tscn")
var speed = preload("res://SpeedPotion.tscn")
var freeze = preload("res://FreezePotionItem.tscn")

var lightCost = 4
var medCost = 8
var heavyCost = 16
var shellCost = 12

var potionCost = 20

func _ready():
	pass
	

func _process(delta):
	player = find_parent("Player")
	fleshCount = player.getFlesh()
	$Money.text = str(fleshCount)
	if (player.global_position.distance_to(find_parent("World").find_node("Shopkeeper").global_position) > 100):
		self.visible = false
	
func dialogic_signal_event(arg):
	if arg == 'open_shop':
		print("bruh")
		self.visible = true

func _on_LightAmmo_pressed():
	if (fleshCount >= lightCost):
		player.addFlesh(-lightCost)
		player.addAmmo(10, "LIGHT")

func _on_MediumAmmo_pressed():
	if (fleshCount >= medCost):
		player.addFlesh(-medCost)
		player.addAmmo(10, "MEDIUM")

func _on_HeavyAmmo_pressed():
	if (fleshCount >= heavyCost):
		player.addFlesh(-heavyCost)
		player.addAmmo(10, "HEAVY")

func _on_Shells_pressed():
	if (fleshCount >= shellCost):
		player.addFlesh(-shellCost)
		player.addAmmo(10, "SHELLS")

func _on_HealthPotion_pressed():
	if (fleshCount >= potionCost && player.availableInventory() > 0):
		var inst = health.instance()
		inst.spawn(player)
		player.addFlesh(-potionCost)


func _on_SpeedPotion_pressed():
	if (fleshCount >= potionCost && player.availableInventory() > 0):
		var inst = speed.instance()
		inst.spawn(player)
		player.addFlesh(-potionCost)


func _on_FreezePotion_pressed():
	if (fleshCount >= potionCost && player.availableInventory() > 0):
		var inst = freeze.instance()
		inst.spawn(player)
		player.addFlesh(-potionCost)


func _on_Button_pressed():
	self.visible = false
