extends Node2D


func _ready():
	$fire/animation.play('happy_float')


func _process(_delta):
	if Global.next_part != null:
		$next.texture = load('res://assets/parts/' + Global.next_part + '.png')
	else:
		$next.texture = null

	if Global.holding_part != null:
		$holding.texture = load('res://assets/parts/' + Global.holding_part + '.png')
	else:
		$holding.texture = null

	$score.text = str(Global.score)

	if Global.turn_limit - Global.turn > 3:
		$fire/intern.texture = load('res://assets/sad_intern.png')


func _on_fire_pressed():
	if Global.score < 3:
		$fire/animation.play('not_enough_points')
		return

	Global.score -= 3
	Global.turn_limit = 7


func _on_restart_button_pressed():
	$fire/intern.visible = true
	$lose.visible = false

	Global.score = 0
	Global.turn = 0
	Global.turn_limit = 3
	Global.next_part = 'i'
	Global.holding_part = null
	Global.inactive_positions = {}

	for child in $play_area.get_children():
		child.queue_free()

	$play_area.generate_new_part()
