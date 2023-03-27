extends Area2D

onready var enemy = preload("res://Enemy.tscn")
export var period : int = 10
export var randomnError : int = 2



func _on_Timer_timeout():
	$Timer.wait_time = period + (randf()*randomnError*2 - randomnError)
	$Timer.start()
	spawnEnemy()
	pass # Replace with function body.

func spawnEnemy():
	randomize()
	var spawnPoint = Vector2(rand_range(0, $CollisionShape2D.shape.extents.x*2), rand_range(0, $CollisionShape2D.shape.extents.y*2))
	var enemyCandidate = null
	while enemyCandidate == null:
		enemyCandidate = enemy.instance()
		enemyCandidate.position = spawnPoint
		#later create detection to stop enemies from spawning on eachother
		get_node("/root/World").add_child(enemyCandidate)
