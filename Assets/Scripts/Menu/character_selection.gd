extends Control

@onready var character_name: Label = $CharacterName
@onready var sprite: Sprite2D = $CharacterAnimation/Sprite2D

var characters: Array[Array]
var current_selected: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_characteres_sprites_names()
	character_name.text = characters[0][1]
	sprite.texture = characters[0][0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_next_character_button_pressed() -> void:
	if current_selected == characters.size() - 1:
		current_selected = 0
	else:
		current_selected += 1
	character_name.text = characters[current_selected][1]
	sprite.texture = characters[current_selected][0]


func _on_previous_character_button_pressed() -> void:
	if current_selected == 0:
		current_selected = characters.size() - 1
	else:
		current_selected -= 1
	character_name.text = characters[current_selected][1]
	sprite.texture = characters[current_selected][0]


func _on_next_scene_button_pressed() -> void:
	GameManager.main_character_info = load("res://Assets/Scripts/Resources/Player/" + characters[current_selected][1] + "CharacterInfo.tres")
	AudioController.play_click_ui_button()
	print(characters[current_selected][1])
	get_tree().change_scene_to_file("res://Assets/Scenes/Areas/level_menu.tscn")

func get_characteres_sprites_names():
	var dir := DirAccess.open("res://Assets/Scripts/Resources/Player/")
	for file in dir.get_files():
		var re = load("res://Assets/Scripts/Resources/Player/" + file.get_basename() + ".tres")
		var tex: Texture2D = re.get("sprite_sheet")
		var char_name = file.get_basename().left(-13)
		print(char_name)
		var arr = [tex, char_name]
		characters.append(arr)
