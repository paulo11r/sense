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

var popup_acessibilidade_scene := preload(
	"res://cenas/componentes/PopupAcessibilidade.tscn"
)

var popup_acessibilidade: Control = null
var popup_intensidade: Control = null

func _ready() -> void:
	GameState.reset()
	for card in cards:
		card.feeling_selected.connect(_on_feeling_selected)

	back_button.pressed.connect(_on_back_pressed)

	_falar_tela()

func _falar_tela() -> void:
	var nomes: Array[String] = []

	for card in cards:
		nomes.append(card.feeling_name)

	var lista_sentimentos := ", ".join(nomes)

	AudioManager.falar(
		"Como você está se sentindo agora? "
		+ "As opções disponíveis são: "
		+ lista_sentimentos
		+ ". Escolha uma opção."
	)

func _on_feeling_selected(
	feeling_name: String,
	description: String,
	icon: Texture2D,
	bg_color: Color,
	border_color: Color
) -> void:
	GameState.selected_feeling = feeling_name
	GameState.selected_description = description
	GameState.selected_icon = icon
	GameState.selected_bg_color = bg_color
	GameState.selected_border_color = border_color

	AudioManager.parar()

	var sentimento := feeling_name.strip_edges().to_lower()

	if sentimento == "dor" or sentimento == "com dor":
		_ir_para_localizacao_dor()
	else:
		_ir_para_resultado()

func _ir_para_localizacao_dor() -> void:
	AudioManager.parar()
	GameState.load_screen("res://cenas/telas/PainLocation.tscn")

func _ir_para_resultado() -> void:
	AudioManager.parar()
	GameState.load_screen("res://cenas/telas/ResultsFinal.tscn")

func _on_back_pressed() -> void:
	AudioManager.parar()
	GameState.load_screen("res://cenas/telas/Menu.tscn")

func _on_accessibility_pressed() -> void:
	AudioManager.parar()

	if is_instance_valid(popup_acessibilidade):
		return

	popup_acessibilidade = popup_acessibilidade_scene.instantiate()
	add_child(popup_acessibilidade)


func _on_acessibility_button_pressed() -> void:
	_on_accessibility_pressed()
