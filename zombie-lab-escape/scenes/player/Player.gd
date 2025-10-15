extends CharacterBody2D

# Build a player state machine using enum

var enemy
var damaged = false
var direction
@export var player_health = 200
@export var speed = 200
@export var dash_speed = 250
@export var dash_duration = 0.2  # Duration of the dash in seconds
# var can_dash = true
var move = Vector2()
# var dash_timer = 0.0
# var dash_multiplier = 1.7
# var is_dashing
# all the dash setup ^^

func _physics_process(_delta):
	move = Vector2.ZERO  # <-- reset movement at the start of the frame

	if Input.is_action_pressed("right"):
		move.x += 1
	if Input.is_action_pressed("left"):
		move.x -= 1
	if Input.is_action_pressed("down"):
		move.y += 1
	if Input.is_action_pressed("up"):
		move.y -= 1

	# --- dash logic (commented) ---
	# if Input.is_action_just_pressed("dash") and can_dash:
	#     is_dashing = true
	#     dash_timer = dash_duration
	#     can_dash = false
	#     $dash_cooldown.start()

	# if is_dashing:
	#     velocity = move.normalized() * dash_multiplier * dash_speed
	#     dash_timer -= delta
	#     if dash_timer <= 0:
	#         is_dashing = false
	# else:
	velocity = move.normalized() * speed  # <-- FIXED: assign to CharacterBody2D velocity

	# Move the player
	move_and_slide()  # <-- works nowaaaaaaa

# --- damage detection ---
func _on_damage_area_area_entered(area: Area2D) -> void:
	if area.is_in_group('enemy_hitbox'):
		enemy = area
		damaged = true
		# current_state = State.damaged

func player_hit():
	player_health -= 20
	if enemy:
		direction = (enemy.global_position - self.global_position).normalized()  # <-- FIXED: correct direction vector
		velocity = direction * 300
	print(player_health)
	damaged = false

func _on_damage_area_area_exited(area: Area2D) -> void:
	if area.is_in_group('enemy_hitbox'):
		enemy = null
