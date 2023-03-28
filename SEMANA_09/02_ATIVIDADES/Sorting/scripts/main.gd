extends Node2D

var numbers = []
var unsorted_color = Color(0.984375, 0.800781, 0.378906, 1)
var rng = RandomNumberGenerator.new()

func _ready():
	generate_new_list()


func generate_new_list():
	rng.randomize()

	for _i in range(6):
		numbers.append(rng.randi_range(1, 9))

	for element in get_tree().get_nodes_in_group("card"):
		element.change_number(numbers.pop_front())
		element.change_color(unsorted_color)
		yield(get_tree().create_timer(0.05), "timeout")


func start_sort():
	var tween = Tween.new()
	add_child(tween)

	for element in get_tree().get_nodes_in_group('card'):
		tween.interpolate_property(
			element,
			'position:y',
			element.initial_y,
			element.exchange_position,
			1,
			Tween.TRANS_SINE,
			Tween.EASE_IN_OUT
		)
		tween.start()

		yield(get_tree().create_timer(0.3), "timeout")
