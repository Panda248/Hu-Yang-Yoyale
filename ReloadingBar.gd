extends ProgressBar

func _ready():
	self.max_value = get_parent().get_parent().get_parent().equipped.get_child(0).getMaxReloadTime()

func _process(delta):
	self.value = get_parent().get_parent().get_parent().equipped.get_child(0).getRemainingReloadTime()
