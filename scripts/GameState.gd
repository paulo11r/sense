extends Node

var selected_feeling: String = ""
var selected_description: String = ""
var selected_icon: Texture2D = null
var selected_bg_color: Color = Color.WHITE
var selected_border_color: Color = Color.BLACK
var selected_intensity: String = ""
var pain_location: String = ""

func reset() -> void:
	selected_feeling = ""
	selected_description = ""
	selected_icon = null
	selected_bg_color = Color.WHITE
	selected_border_color = Color.BLACK
	selected_intensity = ""
	pain_location = ""
