extends CharacterBody2D

#build a player state machine using enum


var enemy
var damaged = false
var direction 
@export var player_health = 200
@export var speed = 250
@export var dash_multiplier =600

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(_delta):
	if damaged == true:
		player_hit()

	else:
		get_input()
	move_and_slide()

func _on_damage_area_area_entered(area: Area2D) -> void:
	if area.is_in_group('enemy_hitbox'):
		enemy = area
		damaged = true
		#current_state = State.damaged
		

func player_hit():
	player_health -= 20
	direction = (enemy.global_position + self.global_position).normalized()
	velocity = (direction * speed )* 2
	print(player_health)
	damaged = false 


func _on_damage_area_area_exited(area: Area2D) -> void:
	if area.is_in_group('enemy_hitbox'):
		enemy = null

