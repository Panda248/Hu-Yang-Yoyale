extends Panel

var ItemClass = preload("res://Item.tscn")
var item = null

func _ready():
	item = ItemClass.instance()
	add_child(item)


func _process(delta):
	pass
