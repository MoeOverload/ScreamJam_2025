extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if PlayerGlobal.player_dead == true:
		self.visible = true


func _on_play_again_pressed() -> void:
	pass # Replace with function body.


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainMenu/main_menu.tscn")
