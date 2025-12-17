extends RayCast2D

@onready var player_controller: PlayerController = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	position = player_controller.get_local_mouse_position()
	target_position = player_controller.global_position - global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
