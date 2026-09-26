extends Control

@onready var cards: Array[Node] = [
	$MarginContainer/Content/FeelingsGrid/FeelingsCard,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard2,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard3,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard4,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard5,
	$MarginContainer/Content/FeelingsGrid/FeelingsCard6,
]

func _ready() -> void:
	for card in cards:
		card.feeling_selected.connect(_on_feeling_selected)

func _on_feeling_selected(feeling_name: String, description: String, icon: Texture2D) -> void:
	GameState.selected_feeling = feeling_name
	GameState.selected_description = description
	GameState.selected_icon = icon
	print("Sentimento selecionado: ", feeling_name)
