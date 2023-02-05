extends Area2D

onready var animationPlayer = get_node("%AnimationPlayer")

func _init():
	set_pickable(true);
	pass

func _process(delta):
	if Input.is_action_just_pressed("primaryFire"):
		primaryFire();
	pass

func primaryFire():
	if !animationPlayer.is_playing():
		if(randf() > 0.5):
			animationPlayer.play("attackLeft")
		else:
			animationPlayer.play("attackRight")
	pass
