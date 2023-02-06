extends Node2D

export var damage = 1
export var firerate = 1

func _enter_tree():
	$HitBox.damage = damage

func primaryFire():
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("attackLeft")

func secondaryFire():
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("attackRight")
