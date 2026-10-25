extends Node

var selected_feeling: String = ""
var selected_description: String = ""
var selected_icon: Texture2D = null
var selected_bg_color: Color = Color.WHITE
var selected_border_color: Color = Color.BLACK
var selected_intensity: String = ""

var pain_location: String = ""
var pain_description: String = ""
var pain_icon: Texture2D = null

var previous_scene: String = ""

func load_screen(path: String) -> void:
	var app = get_tree().current_scene

	if app != null and "current_screen" in app and is_instance_valid(app.current_screen):
		previous_scene = app.current_screen.scene_file_path

	if app != null and app.has_method("load_screen"):
		app.load_screen(path)
	else:
		push_error("Scene not found " + path)

func return_to_previous_scene() -> void:
	if previous_scene.is_empty():
		return

	var app = get_tree().current_scene
	if app != null and app.has_method("load_screen"):
		app.load_screen(previous_scene)

func reset() -> void:
	selected_feeling = ""
	selected_description = ""
	selected_icon = null
	selected_bg_color = Color.WHITE
	selected_border_color = Color.BLACK
	selected_intensity = ""

	pain_location = ""
	pain_description = ""
	pain_icon = null
