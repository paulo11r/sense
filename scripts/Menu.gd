extends Control

@onready var start_button: Button = $SafeArea/MainColumn/Hero/HeroText/StartButton
@onready var accessibility_button: Button = $SafeArea/MainColumn/Header/AccessibilityButton

var popup_acessibilidade_scene := preload(
	"res://cenas/componentes/PopupAcessibilidade.tscn"
)

var popup_acessibilidade: Control = null


func _ready() -> void:
	print("Menu carregado")

	start_button.pressed.connect(_on_start_pressed)
	accessibility_button.pressed.connect(_on_accessibility_pressed)

	AudioManager.falar(
		"Bem-vindo ao Sense. "
		+ "Aqui é um espaço seguro para você se ouvir. "
		+ "Pressione iniciar para descobrir como você está se sentindo hoje."
	)


func _on_start_pressed() -> void:
	print("Botão iniciar clicado")

	AudioManager.parar()

	var app = get_tree().current_scene

	if app != null and app.has_method("load_screen"):
		app.load_screen("res://cenas/telas/Feelings.tscn")
	else:
		push_error("App não encontrado no Menu.")


func _on_accessibility_pressed() -> void:
	print("Acessibilidade clicada no Menu")

	AudioManager.parar()

	if is_instance_valid(popup_acessibilidade):
		return

	popup_acessibilidade = popup_acessibilidade_scene.instantiate()
	add_child(popup_acessibilidade)
