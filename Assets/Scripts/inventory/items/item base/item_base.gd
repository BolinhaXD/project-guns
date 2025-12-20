extends Sprite2D
class_name ItemBaseHand


@export var player_controller : PlayerController
@export var hands_area: Area2D
@export var raycast_2d: RayCast2D
@export var item_resource: InventoryItem


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = item_resource.in_hand_texture
	position = item_resource.sprite_in_hand_position
	item_resource.item_attack.connect(item_attack)


func _physics_process(_delta: float) -> void:
	var center = hands_area.global_position
	var reach = center.distance_to(raycast_2d.get_collision_point())
	var distance_to_mouse = center.distance_to(player_controller.get_global_mouse_position())
	
	if distance_to_mouse > reach:
		look_at(player_controller.get_global_mouse_position())
		var vetor_direcao = - Vector2(center - player_controller.get_global_mouse_position())
		var comprimento_vetor_direcao = sqrt(pow(vetor_direcao.x, 2) + pow(vetor_direcao.y, 2))
		var vetor_direcao_unitario = Vector2((vetor_direcao.x/comprimento_vetor_direcao), (vetor_direcao.y/comprimento_vetor_direcao))
		global_position = Vector2((center.x + (reach * vetor_direcao_unitario.x)), (center.y + (reach * vetor_direcao_unitario.y)))
	else: 
		global_position = player_controller.get_global_mouse_position()
		rotation_degrees = rad_to_deg(Vector2(5, 0).angle_to(hands_area.get_local_mouse_position()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else: 
		scale.y = 1

func item_attack(): pass
