extends Node2D
class_name ProjectileBase

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var area2d: Area2D = $Area2D
const SPEED: int = 300 
var damage: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage = 10
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta


func deal_damage():
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ground"):
		queue_free()
	elif body is AlienEnemy:
		body.take_damage(damage)
		queue_free()
