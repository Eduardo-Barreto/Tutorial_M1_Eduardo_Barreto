extends Node2D

var is_active = true
var part_type = 'i'
var timer = Timer.new()


var intern_actions = [
	'rotate',
	'move_left',
	'move_right',
	null
]


func get_blocks():
	var blocks = []
	for block in get_children():
		if block is Timer:
			continue

		blocks.append(block)

	return blocks


func inactivate():

	is_active = false

	var higher_block_position = 19

	for block in get_blocks():
		var block_position = Global.position_to_grid(block.position + position)

		if block_position.y < higher_block_position:
			higher_block_position = block_position.y

		Global.inactive_positions[block_position] = block

	get_parent().check_full_line()

	if higher_block_position <= 0:
		get_parent().restart_game()
		return

	get_parent().generate_new_part()


func move(direction: int) -> void:
	for block in get_blocks():
		if not block.can_move(direction):
			return

	var next_pos = Global.position_to_grid(position)
	next_pos.x += direction

	position = next_pos * 54

func move_down():
	if not is_active:
		return

	for block in get_blocks():
		if not block.can_move_down():
			inactivate()
			return

	var next_pos = Global.position_to_grid(position)
	next_pos.y += 1

	position = next_pos * 54

func rotate90():
	for block in get_blocks():
		if not block.can_rotate():
			return

	for block in get_blocks():
		block.rotate90()


func _on_Timer_timeout():

	if not is_active:
		return

	move_down()

	if not Global.intern_turn:
		return

	randomize()
	var random_action = intern_actions[randi() % intern_actions.size()]

	if random_action != null:
		do_action(random_action)


func do_action(action: String):
	if not is_active:
		return

	if action == 'move_right':
		move(1)

	if action == 'move_left':
		move(-1)

	if action == 'move_down':
		move_down()

	if action == 'rotate':
		rotate90()

	if action == 'force_down':
		for _i in range(20):
			move_down()


func _input(event):
	if not is_active:
		return

	if Global.intern_turn:
		return

	if event.is_action_pressed('move_right'):
		do_action('move_right')

	if event.is_action_pressed('move_left'):
		do_action('move_left')

	if event.is_action_pressed('move_down'):
		do_action('move_down')

	if event.is_action_pressed('rotate'):
		do_action('rotate')

	if event.is_action_pressed('force_down'):
		do_action('force_down')


func _ready():
	for block in get_blocks():
		block.set_part_type(part_type)

	move(3)

	timer.connect('timeout', self, '_on_Timer_timeout')
	timer.one_shot = false
	add_child(timer)
	timer.start()
