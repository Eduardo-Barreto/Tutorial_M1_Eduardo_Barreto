extends Node

var part_colors = {
	'i': Color(0.19, 0.73, 0.72, 1),
	'j': Color(0.02, 0.45, 0.53, 1),
	'l': Color(0.92, 0.54, 0.01, 1),
	'o': Color(0.9, 0.77, 0.02, 1),
	's': Color(0.23, 0.6, 0.28, 1),
	't': Color(0.61, 0.2, 0.51, 1),
	'z': Color(0.77, 0.19, 0.13, 1),
}

var inactive_positions = {}
var next_part = 'i'
var holding_part = null
var score = 0
var intern_turn = false

var turn = 0
var turn_limit = 3

func position_to_grid(pos: Vector2) -> Vector2:
	return Vector2(int(pos.x / 54), int(pos.y / 54))
