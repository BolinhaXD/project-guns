extends CanvasLayer

@onready var player: PlayerController = $".."
@onready var health_bar: Control = $"Health Bar"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.life.max_value = player.character_info.health_points
	health_bar.life.value = player.character_info.health_points
	player.take_damage_signal.connect(take_dmg)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func take_dmg(_dmg: float):
	health_bar.take_damage(_dmg)
