extends Sprite2D
@export var speed = 500
var direction = Vector2.ZERO

func _ready():
    $bullet_queuefree_time.start()



func _process(delta: float) -> void:
    if direction != Vector2.ZERO:
        position += direction * speed * delta


func _on_bullet_queuefree_time_timeout() -> void:
    self.queue_free()
