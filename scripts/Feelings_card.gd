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

@export var card_color: Color = Color(0.95, 0.98, 0.96):
	set(value):
		card_color = value
		if is_node_ready():
			_update_style()

@export var accent_color: Color = Color(0.18, 0.5, 0.25):
	set(value):
		accent_color = value
		if is_node_ready():
			_update_style()

signal feeling_selected(feeling_name: String, description: String, icon: Texture2D)

func _ready() -> void:
	_update_display()
	_update_style()
	pressed.connect(_on_pressed)

func _update_display() -> void:
	$MarginContainer/Content/NameLabel.text = feeling_name.to_upper()
	$MarginContainer/Content/DescriptionLabel.text = feeling_description
	if feeling_icon:
		$MarginContainer/Content/IconContainer/Icon.texture = feeling_icon

func _update_style() -> void:
	var style_normal := StyleBoxFlat.new()
	style_normal.bg_color = card_color
	style_normal.set_corner_radius_all(24)
	style_normal.set_border_width_all(3)
	style_normal.border_color = accent_color
	style_normal.shadow_color = Color(0, 0, 0, 0.06)
	style_normal.shadow_size = 6
	style_normal.shadow_offset = Vector2(0, 3)

	var style_pressed := style_normal.duplicate()
	style_pressed.bg_color = card_color.darkened(0.05)

	add_theme_stylebox_override("normal", style_normal)
	add_theme_stylebox_override("hover", style_normal)
	add_theme_stylebox_override("pressed", style_pressed)

	$MarginContainer/Content/NameLabel.add_theme_color_override("font_color", accent_color)
	$MarginContainer/Content/DescriptionLabel.add_theme_color_override("font_color", Color(0.45, 0.45, 0.48))

func _on_pressed() -> void:
	feeling_selected.emit(feeling_name,feeling_description, feeling_icon)
