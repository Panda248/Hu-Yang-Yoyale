extends ProgressBar
export var bossBar = false
export var animationSpeed : float = .1

func _ready():
	self.max_value = get_owner().maxHealth
	$ProgressBar.max_value = self.max_value * 100
	$ProgressBar.value = $ProgressBar.max_value

var parent_rotation 

func _process(delta):
	if(bossBar):
		parent_rotation = get_owner().rotation
		set_rotation(-parent_rotation);
	self.value = get_owner().health
	if($ProgressBar.value != self.value*100):
		$ProgressBar.value -= ($ProgressBar.value - self.value*100)*animationSpeed

