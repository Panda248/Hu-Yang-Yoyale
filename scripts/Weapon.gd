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
export var shootTimeMS = 100
onready var timer = self.shootTimeMS
enum WEAPON_WEIGHT {
	NONE = 0, LIGHT = 1, MEDIUM = 2, HEAVY = 3
}

enum WEAPON_PENETRATION {
	NONE = 0, LOW = 1, NORMAL = 2, HIGH = 3
}

export var weaponWeight = WEAPON_WEIGHT.NONE;
export var weaponPen = WEAPON_PENETRATION.LOW;

var shotTimeStamp = fireRate*-1
var reloadAndShootDelay = 0

func _process(delta):
	if(self.reloadAndShootDelay > 0):
		self.reloadAndShootDelay-= delta*60
	elif(currentClip == 0 && reserveClips > 0):
		currentClip = clip
		reserveClips -= 1

func getWeight():
	return weaponWeight;

func input_action():
	pass

func primaryFire():
	pass

func secondaryFire():
	pass

func reload():
	pass

func alert():
	if(owner.has_signal("alert_enemies")):
		owner.emit_signal("alert_enemies", global_position, alertRadius);
