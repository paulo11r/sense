extends Node

func _ready() -> void:
	_load_feeling_data()

func _load_feeling_data() -> void:
	$MarginContainer/Content/ResultCard/CardContent/NomeLabel.text = GameState.selected_feeling.to_upper()
	$MarginContainer/Content/ResultCard/CardContent/DescricaoLabel.text = GameState.selected_description
	$MarginContainer/Content/ResultCard/CardContent/Intensidade.text = "Intensidade: " + GameState.selected_intensity

	if GameState.selected_icon:
		$MarginContainer/Content/ResultCard/CardContent/"Emoji Label".texture = GameState.selected_icon

	_apply_card_colors()

func _apply_card_colors() -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = GameState.selected_bg_color
	style.border_color = GameState.selected_border_color
	style.set_corner_radius_all(24)
	style.set_border_width_all(3)

	$MarginContainer/Content/ResultCard.add_theme_stylebox_override("panel", style)
