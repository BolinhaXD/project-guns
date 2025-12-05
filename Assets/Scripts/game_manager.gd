extends Node

var candy = 0
var score = 0

func _process(_delta: float) -> void:
	$GUI/Candy.text = "Candy: " + str(candy)
