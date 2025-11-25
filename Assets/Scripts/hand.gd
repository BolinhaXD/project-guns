extends Node2D

#@onready var pivot: Marker2D = $"../Marker2D"
@export var pivot : Marker2D
@export var player_controller : PlayerController
const reach = 12

func _process(_delta: float) -> void:
	var center = Vector2(pivot.position.x, pivot.position.y)
	var distance_to_mouse = center.distance_to(player_controller.get_local_mouse_position())
	print(center, distance_to_mouse)
	
	if distance_to_mouse > reach:
		var vetor_direcao = -Vector2(center - player_controller.get_local_mouse_position())
		var comprimento_vetor_direcao = sqrt(pow(vetor_direcao.x, 2) + pow(vetor_direcao.y, 2))
		var vetor_direcao_unitario = Vector2((vetor_direcao.x/comprimento_vetor_direcao), (vetor_direcao.y/comprimento_vetor_direcao))
		position = Vector2((center.x + (reach * vetor_direcao_unitario.x)), (center.y + (reach * vetor_direcao_unitario.y)))
	else: 
		position = player_controller.get_local_mouse_position()
