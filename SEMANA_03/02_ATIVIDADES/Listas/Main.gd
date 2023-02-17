extends Node2D

var myList = ['arroz', 'feijao', 'batata', 'frango', 'alface']
var userList = []


func _on_NameInput_text_changed(new_text):
	# altera o texto de boas vindas de acordo com o nome do usuário
	$Welcome.text = 'Seja bem vinde, {name}!'.format({'name': new_text})


func _on_Button1_pressed():
	# alterna a visibilidade do texto padrao
	$Label1.visible = !$Label1.visible


func _on_ShowList_pressed():
	# mostra a lista separada por vírgulas
	$List.text = ', '.join(myList)


func _on_ShowUserList_pressed():
	# separa o texto em vírgulas
	userList = $UserListInput.text.split(',')

	for i in range(len(userList)):
		# remove os espaços sobrando entre os itens
		userList[i] = userList[i].strip_edges()

	# mostra a lista na tela
	$UserList.text = ', '.join(userList)
