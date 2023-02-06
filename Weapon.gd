class_name Weapon
extends Node2D


export var damage := 1
export var currentClip = 10
export var clip := 10
export var reloadTimeFrames : = 60
export var fireRate := 10
export var reserveClips := 2

var shotTimeStamp = fireRate*-1
var reloadAndShootDelay = 0

func primaryFire():
	pass

func secondaryFire():
	pass
