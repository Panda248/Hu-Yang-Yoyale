extends Node2D
class_name Weapon

export var damage := 1
export var currentClip = 10
export var clip := 10
export var reloadTimeFrames : = 60
export var fireRate := 10
export var reserveClips := 2
export var knockbackMultiplier := 0
export var selfKnockback := 0
export var defaultAlertRadius := 1000
export var shootTimeMS = 100
export var ammo_type = "LIGHT"
onready var timer = self.shootTimeMS
var alertRadius = defaultAlertRadius
var attachment_blacklist = []
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
	if(find_parent("Player")):
		if(self.reloadAndShootDelay > 0):
				self.reloadAndShootDelay-= delta*60
		elif(currentClip == 0):
			if(find_parent("Player").getAmmo(ammo_type) < clip):
				currentClip = find_parent("Player").getAmmo(ammo_type)
				find_parent("Player").clearAmmo(ammo_type)
			else:
				currentClip = clip
				find_parent("Player").removeAmmo(clip, ammo_type)
func getWeight():
	return weaponWeight;

func getAttachmentBlacklist():
	return attachment_blacklist

func input_action(): 
	pass

func primaryFire():
	pass

func secondaryFire():
	pass

func reload():
	var clipDif = clip-currentClip
	if (clipDif>0 && self.reloadAndShootDelay <= 0 && find_parent("Player").getAmmo(ammo_type) > 0):
		if(find_parent("Player").getAmmo(ammo_type) < clipDif):
			currentClip += find_parent("Player").getAmmo(ammo_type)
			find_parent("Player").clearAmmo(ammo_type)
		else:
			currentClip = clip
			find_parent("Player").removeAmmo(clipDif, ammo_type)
		self.reloadAndShootDelay = reloadTimeFrames
		$ReloadSFX.play(0)

func suppress(value):
	alertRadius*=value

func resetSuppress():
	alertRadius = defaultAlertRadius

func add_mags(value):
	reserveClips += value

func alert():
	if(is_instance_valid(find_parent("Player"))):
		if(find_parent("Player").has_method("alertEnemies")):
			find_parent("Player").alertEnemies(alertRadius)
