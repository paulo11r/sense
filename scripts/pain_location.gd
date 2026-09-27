extends Control

@onready var cards: Array[Node] = [
	$MarginContainer/Content/FeelingsGrid/FeelingsCard,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard2,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard3,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard4,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard5,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard6
]

@onready var back_button: Button = $MarginContainer/Content/Header/BackButton

var popup_confirmacao_scene := preload(
	"res://cenas/componentes/PopupConfirmacao.tscn"
)

var popup_acessibilidade_scene := preload(
	"res://cenas/componentes/PopupAcessibilidade.tscn"
)

var popup_confirmacao: Control = null
var popup_acessibilidade: Control = null


func _ready() -> void:
	print("PainLocation carregada")

	for card in cards:
		if not card.feeling_selected.is_connected(_on_location_selected):
			card.feeling_selected.connect(_on_location_selected)

	if not back_button.pressed.is_connected(_on_back_pressed):
		back_button.pressed.connect(_on_back_pressed)

	_falar_tela()


func _falar_tela() -> void:
	AudioManager.falar(
		"Mostre onde você está sentindo dor. "
		+ "Escolha entre cabeça, peito, barriga, braço, perna ou garganta."
	)


func _on_location_selected(
	feeling_name: String,
	description: String,
	icon: Texture2D,
	bg_color: Color,
	border_color: Color
) -> void:
	print("Local da dor selecionado: ", feeling_name)

	GameState.pain_location = _formatar_local_dor(
		feeling_name
	)

	GameState.pain_description = description
	GameState.pain_icon = icon

	AudioManager.parar()

	if is_instance_valid(popup_confirmacao):
		return

	popup_confirmacao = popup_confirmacao_scene.instantiate()

	popup_confirmacao.tipo_confirmacao = "local_dor"

	add_child(popup_confirmacao)

	print(
		"Confirmação do local da dor aberta: ",
		GameState.pain_location
	)


func _formatar_local_dor(local: String) -> String:
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


func _on_back_pressed() -> void:
	print("Voltando de PainLocation para Feelings")

	AudioManager.parar()

	GameState.pain_location = ""
	GameState.pain_description = ""

	var app = get_tree().current_scene

	if app != null and app.has_method("load_screen"):
		app.load_screen(
			"res://cenas/telas/Feelings.tscn"
		)
	else:
		push_error(
			"App não encontrado para voltar para Feelings."
		)


func _on_accessibility_pressed() -> void:
	print("Acessibilidade clicada em PainLocation")

	AudioManager.parar()

	if is_instance_valid(popup_acessibilidade):
		return

	popup_acessibilidade = popup_acessibilidade_scene.instantiate()
	add_child(popup_acessibilidade)

	print(
		"Popup de acessibilidade aberto em PainLocation"
	)
