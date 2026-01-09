extends ProjectileBase

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage = 5
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	sprite2d.rotation += 0.1
	area2d.rotation += 0.1
