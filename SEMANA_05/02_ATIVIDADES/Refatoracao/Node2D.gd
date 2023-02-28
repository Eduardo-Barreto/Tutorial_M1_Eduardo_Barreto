extends Node2D

var temImpar = false
var numero = 0
var nome = ''
var lista = []


func _on_Button_pressed():
	# coletando dados inseridos pelo usuário
	numero = int($Numero.text)
	nome = $Nome.text
	$LabelNumero.text = str(numero)
	$LabelNome.text = nome


func _on_Button2_pressed():
	# incrementando o número inserido pelo usuário
	for i in range(10):
		numero += i
		lista.append(numero)

	$LabelNumero.text = str(numero)


func _on_Button3_pressed():
	# mudando o nome do usuário de acordo com os dados da lista
	# se houver algum número ímpar o nome deve adicionar "baldo" ao final
	temImpar = false
	for item in lista:
		if item % 2 == 1:
			temImpar = true

	if temImpar:
		$LabelNome.text = nome + 'baldo'
