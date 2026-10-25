extends Control

@onready var cards: Array[Node] = [
	$MarginContainer/Content/FeelingsGrid/FeelingsCard,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard2,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard3,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard4,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard5,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard6
]

@onready var back_button: Button = \
	$MarginContainer/Content/Header/BackButton


var popup_acessibilidade_scene := preload(
	"res://cenas/componentes/PopupAcessibilidade.tscn"
)

var popup_acessibilidade: Control = null
var popup_intensidade: Control = null


func _ready() -> void:
	for card in cards:
		if not card.feeling_selected.is_connected(
			_on_location_selected
		):
			card.feeling_selected.connect(
				_on_location_selected
			)

	if not back_button.pressed.is_connected(
		_on_back_pressed
	):
		back_button.pressed.connect(
			_on_back_pressed
		)

	_falar_tela()


func _falar_tela() -> void:
	AudioManager.falar(
		"Mostre onde você está sentindo dor. "
		+ "Escolha entre cabeça, peito, barriga, "
		+ "braço, perna ou garganta."
	)


func _on_location_selected(
	feeling_name: String,
	description: String,
	icon: Texture2D,
	_bg_color: Color,
	_border_color: Color
) -> void:
	GameState.pain_location = _formatar_local_dor(
		feeling_name
	)

	GameState.pain_description = description
	GameState.pain_icon = icon

	AudioManager.parar()

	_ir_para_resultado()

func _ir_para_resultado() -> void:
	AudioManager.parar()
	GameState.load_screen("res://cenas/telas/ResultsFinal.tscn")

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
	AudioManager.parar()

	GameState.pain_location = ""
	GameState.pain_description = ""
	GameState.pain_icon = null

	GameState.load_screen("res://cenas/telas/Feelings.tscn")

func _on_accessibility_pressed() -> void:
	AudioManager.parar()

	if is_instance_valid(
		popup_acessibilidade
	):
		return

	popup_acessibilidade = \
		popup_acessibilidade_scene.instantiate()

	add_child(
		popup_acessibilidade
	)
