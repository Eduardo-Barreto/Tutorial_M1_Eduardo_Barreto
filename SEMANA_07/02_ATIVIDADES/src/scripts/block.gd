extends Node2D

export (Color) var color = Color(1, 1, 1, 1)
var part_type = 'i'


func set_part_type(type: String):
	part_type = type
	$shape.color = Global.part_colors[part_type]


func can_move_down() -> bool:
	var next_pos = Global.position_to_grid(position + get_parent().position)
	next_pos.y += 1

	if next_pos.y >= 20:
		return false


	return not Global.inactive_positions.has(next_pos)


func can_move(direction: int) -> bool:
	var next_pos = Global.position_to_grid(position + get_parent().position)
	next_pos.x += direction

	if next_pos.x > 9 or next_pos.x < 0:
		return false

	return not Global.inactive_positions.has(next_pos)


func can_rotate():
	var next_pos = Vector2()
	next_pos.x = position.y
	next_pos.y = -position.x

	next_pos.x = Global.position_to_grid(next_pos + get_parent().position).x
	next_pos.y = Global.position_to_grid(next_pos + get_parent().position).y

	if next_pos.x > 9 or next_pos.x < 0:
		return false

	if next_pos.y >= 19:
		return false

	return not Global.inactive_positions.has(next_pos)



func rotate90():
	var next_pos = position

	next_pos.x = position.y
	next_pos.y = -position.x

	position = next_pos


func _ready():
	set_part_type(part_type)
