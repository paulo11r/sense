extends Control

func _ready() -> void:
	print("Menu carregado")
	$SafeArea/MainColumn/Hero/HeroText/StartButton.pressed.connect(_on_start_pressed)

func _on_start_pressed() -> void:
	print("Botão iniciar clicado")
	App.load_screen("res://cenas/telas/Feelings.tscn")
