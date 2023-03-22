extends ProgressBar

export var animationSpeed : float = .1

func _ready():
	self.max_value = find_parent("Player").maxHealth
	$ProgressBar.max_value = self.max_value * 100
	$ProgressBar.value = $ProgressBar.max_value

func _process(delta):
	self.value = find_parent("Player").health
	if($ProgressBar.value != self.value*100):
		$ProgressBar.value -= ($ProgressBar.value - self.value*100)*animationSpeed

