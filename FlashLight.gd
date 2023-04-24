extends Weapon

func _ready():
	attachment_blacklist = ["SCOPE", "SUPPRESSOR"]

func primaryFire():
	$Light2D.visible = !$Light2D.visible 
func input_action():
	if Input.is_action_just_pressed("game_primary_fire"):
		primaryFire()

