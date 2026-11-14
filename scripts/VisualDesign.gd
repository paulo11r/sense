extends RefCounted
## Shared presentation tokens, without navigation or state changes.
const INK = Color("30263f")
const PURPLE = Color("7652ac")
const BODY = preload("res://fontes/Body.tres")
const HEADING = preload("res://fontes/Heading.tres")

static func surface(color: Color, radius: int = 32, padding: float = 24.0) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.set_corner_radius_all(radius)
	box.content_margin_left = padding
	box.content_margin_right = padding
	box.content_margin_top = padding
	box.content_margin_bottom = padding
	box.anti_aliasing = true
	return box

static func apply(node: Node) -> void:
	if node is Button:
		var primary: bool = node.name in ["StartButton", "RetryButton", "BotaoConfirmar"]
		if not node.has_signal("feeling_selected"):
			var color := PURPLE if primary else Color("efe9f5")
			if node.name.begins_with("Btn"):
				color = Color("faf7f2")
			if node is CheckButton:
				color = Color(0, 0, 0, 0)
			node.add_theme_stylebox_override("normal", surface(color))
			node.add_theme_stylebox_override("hover", surface(color.lightened(0.08) if primary else Color("e4d9ee")))
			node.add_theme_stylebox_override("pressed", surface(color.darkened(0.09) if primary else Color("ddd1e9")))
			for key in ["font_color", "font_hover_color", "font_pressed_color", "icon_normal_color", "icon_hover_color", "icon_pressed_color"]:
				node.add_theme_color_override(key, Color.WHITE if primary else INK)
		var focus := surface(Color(0, 0, 0, 0))
		focus.set_border_width_all(5)
		focus.border_color = Color("543775")
		node.add_theme_stylebox_override("focus", focus)
		node.add_theme_font_override("font", HEADING)
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		if node.name in ["AcessibilityButton", "AccessibilityButton"]:
			node.tooltip_text = "Áudio e acessibilidade"
		if node.name == "BackButton":
			node.tooltip_text = "Voltar"
		if node.name == "BotaoFechar":
			node.tooltip_text = "Fechar configurações"
		if node is CheckButton:
			for state in ["checked", "checked_disabled"]:
				node.add_theme_icon_override(state, preload("res://recursos/ui/toggle-on.svg"))
			for state in ["unchecked", "unchecked_disabled"]:
				node.add_theme_icon_override(state, preload("res://recursos/ui/toggle-off.svg"))
		if not node.has_meta("visual_feedback"):
			node.set_meta("visual_feedback", true)
			node.button_down.connect(func(): _feedback(node, Color(0.87, 0.82, 0.94), 0.08))
			node.button_up.connect(func(): _feedback(node, Color.WHITE, 0.16))
	if node is PanelContainer and node.name != "ResultCard":
		var color := Color.WHITE
		if node.name.begins_with("Plate"):
			color = [Color("f1d4c4"), Color("ded2ef"), Color("dce9e1")][int(str(node.name).right(1))]
		elif node.name in ["CardAudio", "CardVoz"]:
			color = Color("f6f2f8")
		elif node.name == "PanelContainer":
			color = Color(1, 1, 1, 0.45)
		node.add_theme_stylebox_override("panel", surface(color, 40 if node.name == "Card" else 32, 0.0))
	if node is HSlider:
		var track := surface(Color("e2d8eb"), 7, 0)
		track.content_margin_top = 6
		track.content_margin_bottom = 6
		node.add_theme_stylebox_override("slider", track)
		var fill := track.duplicate()
		fill.bg_color = PURPLE
		node.add_theme_stylebox_override("grabber_area", fill)
		node.add_theme_stylebox_override("grabber_area_highlight", fill)
		node.add_theme_icon_override("grabber", preload("res://recursos/ui/slider-knob.svg"))
		node.add_theme_icon_override("grabber_highlight", preload("res://recursos/ui/slider-knob.svg"))
	for child in node.get_children():
		apply(child)

static func _feedback(control: Control, color: Color, duration: float) -> void:
	control.create_tween().tween_property(control, "self_modulate", color, duration)

static func enter(control: Control) -> void:
	control.modulate.a = 0.0
	control.create_tween().tween_property(control, "modulate:a", 1.0, 0.24).set_trans(Tween.TRANS_SINE)
	var art := control.find_child("Art", true, false)
	if art:
		for i in art.get_child_count():
			var plate: Control = art.get_child(i)
			plate.modulate.a = 0.0
			plate.create_tween().tween_property(plate, "modulate:a", 1.0, 0.32).set_delay(i * 0.07)
