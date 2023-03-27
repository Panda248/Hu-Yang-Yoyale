extends CanvasLayer

func _process(delta):
	if($BloodSplatter.modulate.a > 0):
		$BloodSplatter.modulate.a -= 10*delta
