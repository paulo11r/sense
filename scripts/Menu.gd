extends Control


func _ready() -> void:
	print("Menu carregado")
	$SafeArea/MainColumn/Hero/HeroText/StartButton.pressed.connect(_on_start_pressed)


func _on_start_pressed() -> void:
	print("Botão iniciar clicado")
	
	var app := get_parent().get_parent()
	app.load_screen("res://cenas/telas/Feelings.tscn")
