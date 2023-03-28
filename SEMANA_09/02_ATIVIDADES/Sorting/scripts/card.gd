extends Area2D

var number = 0
var sorted = false
var initial_y = 560
var exchange_position = 190

func change_number(new_number):
	number = new_number
	sorted = false

	$top_number.text = str(number)
	$center_number.text = str(number)
	$bottom_number.text = str(number)

	var tween = Tween.new()

	add_child(tween)

	# sobe e desce por 0.5 segundo

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
