extends Node2D
var n_zombie = preload("res://scenes/enemies/Base Zombie/enemy.tscn")
var spawn_cap = 10

func _ready():
	$spawn_timer.start()
	
func _process(_delta):    
	if SpawnerGlobal.nz_spawn_number >= spawn_cap:
		$spawn_timer.stop()
	
	
	
		
func _on_spawn_timer_timeout() -> void:
	if SpawnerGlobal.nz_spawn_number >= spawn_cap:
		$spawn_timer.stop()
		return
	var new_zombie = n_zombie.instantiate()
	get_tree().current_scene.add_child(new_zombie)
	new_zombie.position = $Marker2D.position
	SpawnerGlobal.nz_spawn_number += 1
	print("spawning number",SpawnerGlobal.nz_spawn_number)
