extends Node2D
@export var n_zombie : PackedScene
var spawn_cap = 10

func _ready():
    print("Spawner ready")
    $spawn_timer.start()   
func _process(_delta):    
    if SpawnerGlobal.nz_spawn_number <= spawn_cap:
        $spawn_timer.stop()
    else:
        $spawn_timer.start()
func _on_spawn_timer_timeout() -> void:
    var new_zombie = n_zombie.instantiate()
    get_tree().current_scene.add_child(new_zombie)
    new_zombie.global_position = $Marker2D.global_position
    SpawnerGlobal.nz_spawn_number += 1
    print("spawning number",SpawnerGlobal.nz_spawn_number)