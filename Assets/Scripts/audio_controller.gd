extends Node2D

@export var mute: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not mute:
		play_music()

func play_music():
	if not mute:
		$Music.play()
	
func play_click_ui_button():
	if not mute:
		$ClickUIButton.play()
	
func play_jump():
	if not mute:
		$Jump.play()
		
func play_end():
	if not mute:
		$Music.stop()
		$End.play()

func play_hurt():
	if not mute:
		$Hurt.play()
