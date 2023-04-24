extends WeaponItem

func _ready():
	._ready()
	$Attachments/BaseScope.monitorable = false
	$Attachments/BaseScope.monitoring = false
	$Attachments/BaseScope/Icon.visible = false
	$Attachments/BaseScope/Quantity.visible = false
	$Attachments/BaseScope/Sprite.visible = true
 
