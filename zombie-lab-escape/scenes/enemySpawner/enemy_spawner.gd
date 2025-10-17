extends Node2D
var n_zombie = preload("res://scenes/enemies/Base Zombie/enemy.tscn")
@export var spawn_cap = 50
@export var player_proximity_radius = 200.0
@export var min_near_player = 5
@onready var player = null

func _ready():
	$spawn_timer.start()
	player = get_tree().current_scene.get_node("Player")  # adjust path to your player node

func _process(_delta):
	if not player:
		return

	# Count zombies near player
	var zombies_near_player = 0
	for zombie in get_tree().current_scene.get_children():
		if zombie.is_in_group("nz_enemy"):
			if zombie.global_position.distance_to(player.global_position) <= player_proximity_radius:
				zombies_near_player += 1

	# Spawn if below minimum and under global cap
	if zombies_near_player < min_near_player and SpawnerGlobal.nz_spawn_number < spawn_cap:
		spawn_zombie_near_player()

func _on_spawn_timer_timeout() -> void:
	# Optional: still spawn randomly around spawner
	if SpawnerGlobal.nz_spawn_number < spawn_cap:
		var new_zombie = n_zombie.instantiate()
		get_tree().current_scene.add_child(new_zombie)
		new_zombie.position = self.position
		SpawnerGlobal.nz_spawn_number += 1
		print("spawning number", SpawnerGlobal.nz_spawn_number)

func spawn_zombie_near_player():
	var new_zombie = n_zombie.instantiate()
	get_tree().current_scene.add_child(new_zombie)
	var angle = randf() * PI * 2
	var radius = randf() * player_proximity_radius
	new_zombie.global_position = player.global_position + Vector2(cos(angle), sin(angle)) * radius
	SpawnerGlobal.nz_spawn_number += 1
	print("Spawning near player, total zombies:", SpawnerGlobal.nz_spawn_number)
