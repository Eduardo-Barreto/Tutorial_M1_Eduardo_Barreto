extends Area2D

var number = 0
var initial_y = 560
var exchange_position = 190
var unsorted_color = Color(0.984375, 0.800781, 0.378906, 1)
var rng = RandomNumberGenerator.new()
var tween = Tween.new()

func change_number(new_number):
	number = new_number

	$top_number.text = str(number)
	$center_number.text = str(number)
	$bottom_number.text = str(number)

	tween.interpolate_property(
		self,
		'position:y',
		initial_y,
		position.y - 10,
		.25,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
	)

	tween.interpolate_property(
		self,
		'position:y',
		position.y - 10,
		initial_y,
		.25,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		.25
	)

	tween.start()


func change_color(color):
	$back.color = color


func reset():
	rng.randomize()
	change_number(rng.randi_range(1, 9))
	change_color(unsorted_color)


func change_position(index):
	var new_position = index*290 + 235

	tween.interpolate_property(
		self,
		'position:y',
		initial_y,
		exchange_position,
		1,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
	)

	tween.interpolate_property(
		self,
		'position:x',
		position.x,
		new_position,
		1,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		1
	)

	tween.interpolate_property(
		self,
		'position:y',
		exchange_position,
		initial_y,
		1,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		2
	)

	tween.start()



func _ready():
	add_child(tween)