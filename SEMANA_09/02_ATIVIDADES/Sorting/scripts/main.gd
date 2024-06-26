extends Node2D

var rng = RandomNumberGenerator.new()
var tween = Tween.new()
var sorting_methods = ["bubble_sort", "insertion_sort"]
var sort_method = ''
signal sort_finished

var sorting = false

onready var cards = get_tree().get_nodes_in_group('card')

var colors = {
	'unsorted': Color(0.984375, 0.800781, 0.378906, 1),
	'active': Color(0.007843, 0.611765, 0.835294),
	'wrong': Color(0.901961, 0.388235, 0.407843, 1),
	'right': Color(0.647059, 0.788235, 0.490196, 1)
}


func generate_new_list():
	for element in get_tree().get_nodes_in_group("card"):
		element.reset()
		yield(get_tree().create_timer(0.05), "timeout")


func swap(index1, index2):
	cards[index1].change_position(index2)
	cards[index2].change_position(index1)

	var temp = cards[index1]
	cards[index1] = cards[index2]
	cards[index2] = temp


func start_sort():
	if sorting:
		return

	$'Panel/left_button'.color = colors.active
	$'Panel/right_button'.color = colors.active

	sorting = true
	hide_buttons()
	sort_method = sorting_methods[randi() % len(sorting_methods)]
	call(sort_method)


func bubble_sort():
	for _i in range(len(cards)-1):
		for card in range(len(cards)-1):
			cards[card].change_color(colors.active)
			var current_card = cards[card].number
			var next_card = cards[card+1].number

			if current_card > next_card:
				swap(card, card+1)
				card += 1
				yield(get_tree().create_timer(3), "timeout")

			cards[card].change_color(colors.unsorted)

	emit_signal('sort_finished')


func insertion_sort():
	for i in range(1, len(cards)):
		var current_card = i
		cards[current_card].change_color(colors.active)
		var j = i

		while j > 0 and cards[j-1].number > cards[j].number:
			swap(j, j-1)
			current_card -= 1
			j -= 1
			yield(get_tree().create_timer(3.2), "timeout")

		cards[current_card].change_color(colors.unsorted)

	emit_signal('sort_finished')


func _on_sort_finished():
	$Panel.visible = true


func choice_insertion():
	if not sorting:
		return

	if sort_method != 'insertion_sort':
		$'Panel/left_button'.color = colors.wrong
		$'Panel/right_button'.color = colors.right
		$'Panel/right_button'.color.a = 0.5
	else:
		$'Panel/left_button'.color = colors.right
		$'Panel/right_button'.color = colors.wrong
		$'Panel/right_button'.color.a = 0.5

	sorting = false
	yield(get_tree().create_timer(3), "timeout")

	$Panel.visible = false
	generate_new_list()
	show_buttons()


func choose_bubble():
	if not sorting:
		return

	if sort_method != 'bubble_sort':
		$'Panel/right_button'.color = colors.wrong
		$'Panel/left_button'.color = colors.right
		$'Panel/left_button'.color.a = 0.5
	else:
		$'Panel/right_button'.color = colors.right
		$'Panel/left_button'.color = colors.wrong
		$'Panel/left_button'.color.a = 0.5

	sorting = false
	yield(get_tree().create_timer(3), "timeout")

	$Panel.visible = false
	generate_new_list()
	show_buttons()


func _ready():
	add_child(tween)
	generate_new_list()


func hide_buttons():
	tween.interpolate_property(
		$left_button, 'position:y', 890, 1200, Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		$right_button, 'position:y', 890, 1200, Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		$instruction, 'rect_position:y', 110, -240, Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)

	tween.start()


func show_buttons():
	tween.interpolate_property(
		$left_button, 'position:y', 1200, 890, Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		$right_button, 'position:y', 1200, 890, Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		$instruction, 'rect_position:y', -240, 100, Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)

	tween.start()
