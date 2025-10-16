extends Sprite2D
@export var speed = 500
var direction = Vector2.ZERO
var hit = false

func _ready():
	$bullet_queuefree_time.start()



func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		position += direction * speed * delta
	if hit ==true:
		self.queue_free()
		hit = false

func _on_bullet_queuefree_time_timeout() -> void:
	self.queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("nz_enemy_head"):
		var _enemy_head = area
		hit = true
		
	elif area.is_in_group("nz_enemy_body"):
		var _enemy_body = area
		hit = true
