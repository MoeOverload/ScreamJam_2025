extends CharacterBody2D

#build a player state machine using enum

var antidote
var enemy
var damaged = false
var direction 

@onready var player_health = 200
@export var speed = 200
@export var dash_duration = 0.2  # Duration of the dash in seconds
@onready var anim = $AnimatedSprite2D

var can_dash = true
var can_fire = true

var dash_timer = 0.0
var dash_multiplier = 1.8
var is_dashing
func _ready() -> void:
	PlayerGlobal.p_Health = player_health


func _ready() -> void:
	PlayerGlobal.p_Health = player_health

func death():
	#play anim
	PlayerGlobal.player_dead = true


func player_hit():
	if damaged == true:
		player_health -= 20
		direction = (enemy.global_position + self.global_position).normalized()
		velocity = direction * speed * 300
		PlayerGlobal.p_Health = player_health
		damaged = false 

func shoot():
	var bullet_scene = preload("res://scenes/bullet/bullet.tscn")
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = global_position
	var mouse_position = get_global_mouse_position()
	var bullet_direction = (mouse_position - global_position).normalized() 
	new_bullet.direction = bullet_direction
	get_tree().current_scene.add_child(new_bullet)
	new_bullet.position = self.position 
	can_fire = false
	$shooting_cooldown.start()

func dash():
	# Handle dash function
	is_dashing = true
	dash_timer = dash_duration
	can_dash = false
	$dash_cooldown.start()

func get_input(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if velocity == Vector2.ZERO:
		anim.play("idle")
		$pistol.visible = true
	elif input_direction.y > 0:
		anim.play("run_down")
		$pistol.visible = true
	elif input_direction.y < 0:
		anim.play("run_up")
		$pistol.visible = false
	elif input_direction.x > 0:
		anim.play("run_right")
		$pistol.visible = true
	elif input_direction.x < 0:
		anim.play("run_left")
		$pistol.visible = true



	if is_dashing:
		velocity = input_direction.normalized() * dash_multiplier  * speed
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
func _physics_process(delta):
	if Input.is_action_just_pressed("pickup") and PlayerGlobal.anti_pickup == true:
		handle_anti_pickup()
	if player_health <= 0:
		death()
	if damaged == true:
		player_hit()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_fire:
		shoot()
	if Input.is_action_just_pressed("dash") and can_dash:
		dash()
	get_input(delta)
	move_and_slide()
	# --- collision handling ---
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision:
			velocity = velocity.slide(collision.get_normal())




	
	

func _on_dash_cooldown_timeout() -> void:
	can_dash = true

func _on_damage_area_area_entered(area: Area2D) -> void:
	if area.is_in_group('enemy_hitbox'):
		enemy = area
		damaged = true
		
		



func _on_shooting_cooldown_timeout() -> void:
	can_fire = true
	


func _on_damage_area_area_exited(area: Area2D) -> void:
	if area.is_in_group('enemy_hitbox'):
		enemy = null
		damaged = false


func _on_pickup_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("antidote"):
		antidote = area
		PlayerGlobal.anti_pickup = true


func _on_pickup_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("antidote"):
		PlayerGlobal.anti_pickup = false
		antidote = null
