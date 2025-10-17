extends CharacterBody2D
var health = 20
var player_detected = false
var is_headshot = false
var is_bodyshot = false
var direction
var player
var SPEED = 40
var wander_speed = 10
var random_direction
var bullet
enum state {
	IDLE,
	CHASE,
	WANDER,
	ATTACK,
	HURT,
	DEAD,
	}
@onready var current_state = state.IDLE
@onready var idle_timer : Timer =  $idle_timer
@onready var wander_timer : Timer = $rand_move_timer
func _ready() -> void:
	idle_timer.start()
func _physics_process(delta: float) -> void:
	match current_state:
		state.IDLE:
			handle_idle(delta)
		state.WANDER:
			handle_wander(delta)
		state.ATTACK:
			handle_attack(delta)
		state.CHASE:
			handle_chase(delta)
		state.HURT:
			handle_hurt(delta)
		state.DEAD:
			handle_death()
	move_and_slide()
	
	
		
	
func handle_idle(_delta):
	velocity = Vector2.ZERO
	
	

func handle_chase(_delta):
	if player_detected == true:
		direction =  (player.global_position - self.global_position).normalized()
		velocity = direction * SPEED
		if player.global_position.distance_to(self.global_position) <= 10.00:
			current_state = state.ATTACK
	else:
		velocity = Vector2.ZERO
		current_state = state.IDLE

func handle_wander(_delta):
	if player_detected:
		current_state = state.CHASE
		return
	
	velocity = random_direction.normalized() * wander_speed
	

func randomize_direction():
	
	var x = randf_range(-1.0,1.0)
	var y = randf_range(-1.0,1.0)
	random_direction = Vector2(x,y).normalized()


func handle_attack(_delta):
	
	$enemy_hitbox.visible = true
	$attack_cooldown_timer.start()
	
	 

func handle_hurt(_delta):
	if is_headshot == true:
		health -= 10
	elif is_bodyshot == true:
		health -= 5
	if health <= 0:
		current_state = state.DEAD
func handle_death():
	SpawnerGlobal.nz_spawn_number -= 1
	print("dead",SpawnerGlobal.nz_spawn_number)
	self.queue_free()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_detected = true
		player = body
		current_state = state.CHASE 
		
func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_detected = false
		player = null
		current_state = state.IDLE
	


func _on_idle_timer_timeout():
	current_state = state.WANDER
	randomize_direction()
	wander_timer.start()



	



func _on_headshot_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		bullet = area
		is_headshot = true
		current_state = state.HURT


func _on_bodyshot_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		bullet = area
		is_bodyshot=true
		current_state = state.HURT


func _on_bodyshot_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		bullet = null
		is_bodyshot=false
		


func _on_headshot_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		bullet = null
		is_headshot = false
		


func _on_attack_cooldown_timer_timeout() -> void:
	$enemy_hitbox.visible = false
	current_state = state.IDLE





func _on_rand_move_timer_timeout() -> void:
	current_state = state.IDLE
	idle_timer.start()
