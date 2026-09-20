extends Button

@export var feeling_name: String = "Sentimento":
	set(value):
		feeling_name = value
		if is_node_ready():
			_update_display()

@export var feeling_description: String = "Descrição":
	set(value):
		feeling_description = value
		if is_node_ready():
			_update_display()

@export var feeling_icon: Texture2D:
	set(value):
		feeling_icon = value
		if is_node_ready():
			_update_display()

@export var card_color: Color = Color(0.85, 0.93, 0.87):
	set(value):
		card_color = value
		if is_node_ready():
			_update_style()

signal feeling_selected(feeling_name: String)

func _ready() -> void:
	_update_display()
	_update_style()
	pressed.connect(_on_pressed)

func _update_display() -> void:
	$MarginContainer/Content/NameLabel.text = feeling_name
	$MarginContainer/Content/DescriptionLabel.text = feeling_description
	if feeling_icon:
		$MarginContainer/Content/IconContainer/Icon.texture = feeling_icon

func _update_style() -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = card_color
	style.corner_radius_top_left = 24
	style.corner_radius_top_right = 24
	style.corner_radius_bottom_right = 24
	style.corner_radius_bottom_left = 24
	style.border_width_left = 3
	style.border_width_top = 3
	style.border_width_right = 3
	style.border_width_bottom = 3
	style.border_color = card_color.darkened(0.35)
	add_theme_stylebox_override("normal", style)
	add_theme_stylebox_override("hover", style)
	add_theme_stylebox_override("pressed", style)

func _on_pressed() -> void:
	feeling_selected.emit(feeling_name)
