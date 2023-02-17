extends Node # instancia a classe Node2D

var playing = true # indica se o usuário está jogando ou parado (como um bool, mas representado com inteiros)
var player_score = 0 # score do usuário, incrementada a cada coluna superada
var velocity = 3 # "velocidade" de movimentação do dragão (decremento da posição do cenário)
var gravity = 1.5 # "força gravidade", incremento na posição em y para puxar o dragão para baixo

# executa essa função ao carregar o jogo
func _ready():
	# oculta o "gameover"
	$gameover.hide()


# executa essa função a cada frame (60 FPS)
func _process(_delta):
	
	if playing: # jogando
		# movimenta o cenário do fundo
		$background.position.x -= velocity
		if ($background.position.x) < -200:
			$background.position.x = 600
			
		# movimenta as colunas para colisão
		$columns.position.x -= 2*velocity
		if ($columns.position.x) < -550:
			#TODO: colunas gerando logo no início do código (aumenta pontuacao e pode causar insta gameover)
			$columns.position.x = rand_range(0, 350) - 50
			$columns.position.y = rand_range(0, 400) - 200
		
		# puxa o dragão para baixo
		$dragon.position.y += gravity

		# se bateu no fundo, não desce mais e termina o jogo
		if $dragon.position.y > 480:
			$dragon.position.y = 480
			playing = false # muda o status para "parado"

		# se bateu no teto, não sobe mais
		if $dragon.position.y < -20:
			$dragon.position.y = -20
			
		# se apertou seta para baixo, aumenta o valor de y (posição vertical) do dragão
		if Input.is_action_pressed("ui_down"):
			$dragon.position.y += 2

		# se apertou seta para cima, diminui o valor de y (posição vertical) do dragão
		if Input.is_action_pressed("ui_up"):
			$dragon.position.y -= 2.5 * gravity
			
	else: # parado
		$dragon/dragonImages.playing = false # faz dragão parar de bater as asas
		$gameover.show() # exibe imagem gameover

		# se apertou enter ou space, recomeça o jogo
		if Input.is_action_pressed("ui_accept"):
			player_score = 0 # zera o score
			$score.set_text("0") # zera o score no display
			$dragon/dragonImages.playing = true # faz dragão voltar a bater as asas
			$dragon.position.y = 0 # volta o dragão para a posição original
			$columns.position.x = 400 # muda a posição das colunas
			$gameover.hide() # oculta o gameover
			playing = true # muda o status para "jogando"


# executa essa função quando o dragão bate na coluna
func _on_columns_body_shape_entered(_body_id, _body, _body_shape, local_shape):
	if (local_shape < 2): # esse node tem 3 shapes de colisão: 0 e 1 são as colunas
		playing = false # muda o status para "parado"

# executa essa função quando o dragão atravessa entre as colunas
func _on_columns_body_shape_exited(_body_id, _body, _body_shape, local_shape):
	if (local_shape == 2): # esse node tem 3 shapes de colisão: 0 e 1 são as colunas
		player_score += 1 # aumenta o score
		$score.set_text(str(player_score)) # atualiza o painel
