extends Node2D
class_name Weapon

export var damage := 1
export var currentClip = 10
export var clip := 10
export var reloadTimeFrames : = 60
export var fireRate := 10
export var reserveClips := 2
export var knockbackMultiplier := 0
export var alertRadius := 1000

var shotTimeStamp = fireRate*-1
var reloadAndShootDelay = 0

func _process(delta):
	if(self.reloadAndShootDelay > 0):
		self.reloadAndShootDelay-= delta*60
	elif(currentClip == 0 && reserveClips > 0):
		currentClip = clip
		reserveClips-= delta*60

func primaryFire():
	
	pass

func secondaryFire():
	pass

func alert():
	if(get_owner() is Player):
		get_owner().emit_signal("alert_enemies", global_position, alertRadius);
	else:
		#print(var2str(get_owner()))
		pass

