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
		card.feeling_selected.connect(_on_location_selected)

func _on_location_selected(feeling_name: String, description: String, icon: Texture2D, bg_color: Color, border_color: Color) -> void:
	GameState.pain_location = feeling_name
	GameState.pain_description = description
	
	var app := get_parent().get_parent()
	app.load_screen("res://cenas/telas/IntensityPopup.tscn")
