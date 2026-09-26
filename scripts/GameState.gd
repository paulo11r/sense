extends Node

var selected_feeling: String = ""
var selected_description: String = ""
var selected_icon: Texture2D = null
var selected_intensity: String = ""
var pain_location: String = ""

func reset() -> void:
	selected_feeling = ""
	selected_description = ""
	selected_icon = null
	selected_intensity = ""
	pain_location = ""
