extends Control

@onready var back_button: Button = $MarginContainer/Content/Header/BackButton

@onready var subtitle: Label = $MarginContainer/Content/Subtitle

@onready var nome_label: Label = $MarginContainer/Content/ResultCard/CardContent/NomeLabel
@onready var descricao_label: Label = $MarginContainer/Content/ResultCard/CardContent/DescricaoLabel
@onready var intensidade_label: Label = $MarginContainer/Content/ResultCard/CardContent/Intensidade
@onready var feeling_icon: TextureRect = $MarginContainer/Content/ResultCard/CardContent/TextureRect

@onready var play_again_button: Button = $MarginContainer/Content/ActionButtons/PlayAgainButton
@onready var retry_button: Button = $MarginContainer/Content/ActionButtons/RetryButton

@onready var result_card: PanelContainer = $MarginContainer/Content/ResultCard

var popup_acessibilidade_scene := preload(
	"res://cenas/componentes/PopupAcessibilidade.tscn"
)

var popup_acessibilidade: Control = null


func _ready() -> void:
	print("ResultsFinal carregada")

	_load_feeling_data()
	_apply_card_colors()

	if not back_button.pressed.is_connected(_on_back_pressed):
		back_button.pressed.connect(_on_back_pressed)

	if not play_again_button.pressed.is_connected(_on_play_again_pressed):
		play_again_button.pressed.connect(_on_play_again_pressed)

	if not retry_button.pressed.is_connected(_on_retry_pressed):
		retry_button.pressed.connect(_on_retry_pressed)

	_falar_resultado()


func _load_feeling_data() -> void:
	nome_label.text = GameState.selected_feeling.to_upper()

	var descricao := _get_descricao_sentimento(
		GameState.selected_feeling
	)

	if _sentimento_e_dor():
		var local_dor := _get_local_dor_formatado(
			GameState.pain_location
		)

		if not local_dor.is_empty():
			descricao_label.text = (
				"Local da dor: "
				+ local_dor
				+ "\n"
				+ descricao
			)
		else:
			descricao_label.text = descricao
	else:
		descricao_label.text = descricao

	intensidade_label.text = (
		"Intensidade: "
		+ str(GameState.selected_intensity)
	)

	if GameState.selected_icon != null:
		feeling_icon.texture = GameState.selected_icon
	else:
		feeling_icon.texture = null
		push_warning(
			"Nenhum ícone foi encontrado para o sentimento selecionado."
		)


func _get_descricao_sentimento(sentimento: String) -> String:
	match sentimento.strip_edges().to_lower():
		"calmo":
			return "Sentindo paz e tranquilidade"

		"medo":
			return "Sentindo medo ou insegurança"

		"triste":
			return "Com vontade de chorar"

		"dor", "com dor":
			return "Sentindo muita dor"

		"enjoado":
			return "Com vontade de vomitar"

		"cansado":
			return "Sem energia"

		_:
			return GameState.selected_description


func _sentimento_e_dor() -> bool:
	var sentimento := GameState.selected_feeling.strip_edges().to_lower()

	return sentimento == "dor" or sentimento == "com dor"


func _get_local_dor_formatado(local: String) -> String:
	match local.strip_edges().to_lower():
		"cabeca", "cabeça":
			return "Cabeça"

		"peito":
			return "Peito"

		"barriga":
			return "Barriga"

		"braco", "braço", "dor no braco", "dor no braço":
			return "Braço"

		"perna", "dor na perna":
			return "Perna"

		"garganta", "dor na garganta":
			return "Garganta"

		_:
			return local.strip_edges()


func _get_local_dor_para_fala(local: String) -> String:
	var local_formatado := _get_local_dor_formatado(local)

	match local_formatado:
		"Cabeça":
			return "na cabeça"

		"Peito":
			return "no peito"

		"Barriga":
			return "na barriga"

		"Braço":
			return "no braço"

		"Perna":
			return "na perna"

		"Garganta":
			return "na garganta"

		_:
			if local_formatado.is_empty():
				return ""

			return "em " + local_formatado


func _get_nivel_intensidade(intensidade: int) -> String:
	if intensidade <= 3:
		return "leve"
	elif intensidade <= 7:
		return "moderada"
	else:
		return "intensa"


func _apply_card_colors() -> void:
	var style := StyleBoxFlat.new()

	style.bg_color = GameState.selected_bg_color
	style.border_color = GameState.selected_border_color

	style.set_corner_radius_all(24)
	style.set_border_width_all(3)

	result_card.add_theme_stylebox_override(
		"panel",
		style
	)


func _falar_resultado() -> void:
	var descricao := _get_descricao_sentimento(
		GameState.selected_feeling
	)

	var intensidade := int(GameState.selected_intensity)

	var nivel := _get_nivel_intensidade(
		intensidade
	)

	var texto_fala := ""

	if not subtitle.text.strip_edges().is_empty():
		texto_fala += (
			subtitle.text.strip_edges()
			+ ". "
		)

	texto_fala += (
		"Você escolheu "
		+ GameState.selected_feeling
		+ ". "
	)

	if _sentimento_e_dor():
		var local_fala := _get_local_dor_para_fala(
			GameState.pain_location
		)

		if not local_fala.is_empty():
			texto_fala += (
				"A dor está localizada "
				+ local_fala
				+ ". "
			)

	texto_fala += (
		descricao
		+ ". A intensidade escolhida foi "
		+ str(intensidade)
		+ " de dez, considerada "
		+ nivel
		+ "."
	)

	AudioManager.falar(texto_fala)


func _on_play_again_pressed() -> void:
	print("Fazer de novo clicado")

	AudioManager.parar()

	var app = get_tree().current_scene

	if app != null and app.has_method("load_screen"):
		GameState.reset()

		app.load_screen(
			"res://cenas/telas/Menu.tscn"
		)
	else:
		push_error(
			"App não encontrado para voltar ao Menu."
		)


func _on_retry_pressed() -> void:
	print("Ouvir novamente clicado")

	AudioManager.parar()
	_falar_resultado()


func _on_back_pressed() -> void:
	print("Voltar clicado em ResultsFinal")

	AudioManager.parar()

	var app = get_tree().current_scene

	if app != null and app.has_method("load_screen"):
		GameState.reset()

		app.load_screen(
			"res://cenas/telas/Menu.tscn"
		)
	else:
		push_error(
			"App não encontrado para voltar ao Menu."
		)


func _on_accessibility_pressed() -> void:
	print("Acessibilidade clicada em ResultsFinal")

	AudioManager.parar()

	if is_instance_valid(popup_acessibilidade):
		return

	popup_acessibilidade = popup_acessibilidade_scene.instantiate()
	add_child(popup_acessibilidade)

	print(
		"Popup de acessibilidade aberto em ResultsFinal"
	)
