extends Area2D

onready var animationPlayer = get_node("%AnimationPlayer")

func primaryFire():
	if !animationPlayer.is_playing():
		if(randf() > 0.5):
			animationPlayer.play("attackLeft")
		else:
			animationPlayer.play("attackRight")
	pass
