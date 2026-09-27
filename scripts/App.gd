extends Control

@onready var screen_container: Control = $ScreenContainer

var current_screen: Control = null


func _ready() -> void:
	show_menu()


func show_menu() -> void:
	load_screen("res://cenas/telas/Menu.tscn")


func load_screen(scene_path: String) -> void:
	print("Tentando carregar: ", scene_path)

	if is_instance_valid(current_screen):
		if current_screen.get_parent() == screen_container:
			screen_container.remove_child(current_screen)

		current_screen.queue_free()
		current_screen = null

	var scene_resource: PackedScene = load(scene_path)

	if scene_resource == null:
		push_error("Não foi possível carregar: " + scene_path)
		return

	current_screen = scene_resource.instantiate()
	screen_container.add_child(current_screen)

	print("Tela carregada com sucesso: ", scene_path)
