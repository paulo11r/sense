extends Control

@onready var screen_container: Control = $ScreenContainer

var current_screen: Control


func _ready() -> void:
	show_menu()


func show_menu() -> void:
	load_screen("res://cenas/telas/Menu.tscn")


func load_screen(scene_path: String) -> void:
	if current_screen:
		current_screen.queue_free()

	var scene_resource := load(scene_path)

	if scene_resource == null:
		push_error("Não foi possível carregar: " + scene_path)
		return

	current_screen = scene_resource.instantiate()
	screen_container.add_child(current_screen)
