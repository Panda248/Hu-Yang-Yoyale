extends Control

func _process(delta):
	if(Input.is_physical_key_pressed(KEY_SPACE)):
		$InventoryIcon.hide()
	if(Input.is_physical_key_pressed(KEY_W)):
		$W.hide()
	if(Input.is_physical_key_pressed(KEY_S)):
		$S.hide()
	if(Input.is_physical_key_pressed(KEY_A)):
		$A.hide()
	if(Input.is_physical_key_pressed(KEY_D)):
		$D.hide()
	if(Input.is_physical_key_pressed(KEY_Q)):
		$Q.hide()
	if(Input.is_physical_key_pressed(KEY_E)):
		$E.hide()
	if(Input.is_physical_key_pressed(KEY_SHIFT)):
		$Shift.hide()
	if(Input.is_physical_key_pressed(KEY_CONTROL)):
		$LCtrl.hide()
	if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
		$Click.hide()
