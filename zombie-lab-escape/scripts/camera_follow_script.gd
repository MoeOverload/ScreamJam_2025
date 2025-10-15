extends Camera2D

@export var player: NodePath
@export var side_buffer: float = 50
@export var vertical_buffer: float = 50
@export var smooth_speed: float = 5.9
@export var zoom_factor = 1.0

func ready():
	zoom = zoom_factor

func _process(delta):
	if not player:
		return

	var target = get_node(player).global_position
	var offset = target - global_position

	# Apply buffer
	if abs(offset.x) > side_buffer:
		global_position.x = lerp(global_position.x, target.x - sign(offset.x) * side_buffer, smooth_speed * delta)
	if abs(offset.y) > vertical_buffer:
		global_position.y = lerp(global_position.y, target.y - sign(offset.y) * vertical_buffer, smooth_speed * delta)
