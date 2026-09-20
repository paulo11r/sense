extends Control


func _ready() -> void:
	$Content/StartButton.pressed.connect(_on_start_pressed)
	$Content/AccessibilityButton.pressed.connect(_on_accessibility_pressed)


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/telas/Feelings.tscn")


func _on_accessibility_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/telas/Settings.tscn")
