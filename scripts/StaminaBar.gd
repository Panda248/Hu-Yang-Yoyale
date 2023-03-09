extends ProgressBar

func _ready():
	self.max_value = get_node("%Player").maxStamina


func _process(delta):
	self.value = get_node("%Player").curStamina
	if(ratio < 0.25):
		get("custom_styles/fg").bg_color = Color(1,0,0)
	else:
		if(get_node("%Player").canSprint):
			get("custom_styles/fg").bg_color = Color(0,0.16,1)

