extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Areas/area_1.tscn")



func _on_area_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Areas/1v1_arena.tscn")
	print("Area2")
