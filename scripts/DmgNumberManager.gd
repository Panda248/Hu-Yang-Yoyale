extends Node2D


export (PackedScene) var DamageNumber
export var extremeDamageThreshold = 10

func spawn_damage_number(damage, position):
	var dmg = DamageNumber.instance()
	if(damage > extremeDamageThreshold):
		dmg.modulate = Color.red
	dmg.text = var2str(damage)
	dmg.rect_global_position = position
	dmg.rect_scale *= scale
	add_child(dmg)
	pass # Replace with function body.
