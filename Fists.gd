extends Node2D

export var damage = 1
export var firerate = 1

func _enter_tree():
	$HitBox.damage = damage

func primaryFire():
	if !$AnimationPlayer.is_playing():
		if(randf() > 0.5):
			$AnimationPlayer.play("attackLeft")
		else:
			$AnimationPlayer.play("attackRight")
	pass
