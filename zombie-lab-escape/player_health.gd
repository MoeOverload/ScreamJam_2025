extends Label
var health_label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	health_label = PlayerGlobal.p_Health
	self.text = "Health: " + str(health_label)
