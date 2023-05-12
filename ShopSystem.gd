extends Control

var fleshCount

func _ready():
	pass # Replace with function body.

func _process(delta):
	fleshCount = find_node("Player").getFlesh()
	

func _on_LightAmmo_pressed():
	pass # Replace with function body.


func _on_HeavyAmmo_pressed():
	pass # Replace with function body.


func _on_HealthPotion_pressed():
	pass # Replace with function body.


func _on_SpeedPotion_pressed():
	pass # Replace with function body.


func _on_FreezePotion_pressed():
	pass # Replace with function body.
