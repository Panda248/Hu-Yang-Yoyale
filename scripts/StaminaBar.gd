extends ProgressBar

func _ready():
	self.max_value = find_parent("Player").maxStamina


func _process(delta):
	self.value = find_parent("Player").curStamina
	if(ratio < 0.25):
		get("custom_styles/fg").bg_color = Color(1,0,0)
	else:
		if(find_parent("Player").canSprint):
			get("custom_styles/fg").bg_color = Color(0,0.16,1)

