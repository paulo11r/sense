extends Control

@onready var botao_alterar: Button = $Centralizador/CardConfirmacao/Margens/Conteudo/botoes/BotaoAlterar
@onready var botao_confirmar: Button = $Centralizador/CardConfirmacao/Margens/Conteudo/botoes/BotaoConfirmar
@onready var selecao: Label = $Centralizador/CardConfirmacao/Margens/Conteudo/selecao
@onready var emoji_selecao: TextureRect = $Centralizador/CardConfirmacao/Margens/Conteudo/EmojiSelecao

var tipo_confirmacao: String = "sentimento"


func _ready() -> void:
	botao_alterar.pressed.connect(_on_botao_alterar_pressed)
	botao_confirmar.pressed.connect(_on_botao_confirmar_pressed)

	match tipo_confirmacao:
		"intensidade":
			_configurar_confirmacao_intensidade()

		"local_dor":
			_configurar_confirmacao_local_dor()

		_:
			_configurar_confirmacao_sentimento()


func _configurar_confirmacao_sentimento() -> void:
	selecao.text = GameState.selected_feeling

	if GameState.selected_icon != null:
		emoji_selecao.texture = GameState.selected_icon
		emoji_selecao.show()
	else:
		emoji_selecao.texture = null
		emoji_selecao.hide()

	AudioManager.falar(
		"Você selecionou "
		+ GameState.selected_feeling
		+ ". Pressione confirmar para continuar ou voltar para alterar."
	)


func _configurar_confirmacao_local_dor() -> void:
	selecao.text = GameState.pain_location

	if GameState.pain_icon != null:
		emoji_selecao.texture = GameState.pain_icon
		emoji_selecao.show()
	else:
		emoji_selecao.texture = null
		emoji_selecao.hide()

	AudioManager.falar(
		"Você selecionou "
		+ GameState.pain_location
		+ " como local da dor. "
		+ "Pressione confirmar para continuar ou voltar para alterar."
	)


func _configurar_confirmacao_intensidade() -> void:
	selecao.text = (
		"Intensidade "
		+ str(GameState.selected_intensity)
	)

	emoji_selecao.texture = null
	emoji_selecao.hide()

	AudioManager.falar(
		"Você selecionou intensidade "
		+ str(GameState.selected_intensity)
		+ ". Pressione confirmar para continuar ou voltar para alterar."
	)


func _on_botao_alterar_pressed() -> void:
	AudioManager.parar()
	queue_free()


func _on_botao_confirmar_pressed() -> void:
	AudioManager.parar()

	match tipo_confirmacao:
		"intensidade":
			_ir_para_resultado()

		"local_dor":
			_abrir_popup_intensidade()

		_:
			if _sentimento_e_dor():
				_ir_para_localizacao_dor()
			else:
				_abrir_popup_intensidade()


func _sentimento_e_dor() -> bool:
	var sentimento := GameState.selected_feeling.strip_edges().to_lower()

	return sentimento == "dor" or sentimento == "com dor"


func _ir_para_localizacao_dor() -> void:
	var app = get_tree().current_scene

	if app != null and app.has_method("load_screen"):
		queue_free()

		app.load_screen(
			"res://cenas/telas/PainLocation.tscn"
		)
	else:
		push_error(
			"App não encontrado para abrir PainLocation."
		)


func _abrir_popup_intensidade() -> void:
	var popup_intensidade_scene := load(
		"res://cenas/componentes/PopupIntensividade.tscn"
	)

	if popup_intensidade_scene == null:
		push_error(
			"Não foi possível carregar PopupIntensividade.tscn"
		)
		return

	var popup_intensidade = popup_intensidade_scene.instantiate()

	get_parent().add_child(popup_intensidade)

	queue_free()


func _ir_para_resultado() -> void:
	var app = get_tree().current_scene

	if app != null and app.has_method("load_screen"):
		app.load_screen(
			"res://cenas/telas/ResultsFinal.tscn"
		)
	else:
		push_error(
			"App não encontrado para abrir ResultsFinal."
		)
