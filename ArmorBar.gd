extends ProgressBar

export var animationSpeed : float = .1

func _ready():
	self.max_value = find_parent("Player").totalShield
	$ProgressBar.max_value = self.max_value * 100
	$ProgressBar.value = $ProgressBar.max_value

func _process(delta):
	if(find_parent("Player").totalShield == 0):
		get_parent().visible = false
	else:
		self.max_value = find_parent("Player").totalShield
		$ProgressBar.max_value = self.max_value * 100
		get_parent().visible = true
	self.value = find_parent("Player").curShield
	if($ProgressBar.value != self.value*100):
		$ProgressBar.value -= ($ProgressBar.value - self.value*100)*animationSpeed
