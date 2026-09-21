extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_instance = load("res://Assets/Scenes/Player/player.tscn").instantiate()
	player_instance.character_info = GameManager.main_character_info
	add_child(player_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
