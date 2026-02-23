## Class that controls the main menu
extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Areas/level_menu.tscn")
	# get_tree().change_scene_to_file("res://Assets/Scenes/Areas/area_1.tscn")


func _on_options_button_pressed() -> void:
	print("options scene")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
