extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if PlayerGlobal.can_be_safe == true:
		self.rotate(-80.0)
		PlayerGlobal.can_be_safe = false
		$rotate_timer.start()

	return

func _on_rotate_timer_timeout() -> void:
	self.rotate(80.0)
