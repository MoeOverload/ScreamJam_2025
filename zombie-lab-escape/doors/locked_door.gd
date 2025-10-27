extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if SecretItemGlobal.secret_item_1 == true:
		self.rotate(89.5)
		SecretItemGlobal.secret_item_1 = false
	return	