extends Control

@onready var slider: HSlider = $PainelPopup/Margens/Conteudo/SliderIntensidade

@onready var valor_label: Label = \
	$PainelPopup/Margens/Conteudo/ValorIntensidade

@onready var descricao_label: Label = \
	$PainelPopup/Margens/Conteudo/ValorIntensidade/DescricaoIntensidade

@onready var confirmar_button: Button = \
	$PainelPopup/Margens/Conteudo/AreaConfirmar/BotaoConfirmar

@onready var botao_voltar: Button = \
	$PainelPopup/Margens/Conteudo/BotaoVoltar


func _ready() -> void:
	print("Popup de intensidade aberto")

	slider.value_changed.connect(_on_slider_changed)
	confirmar_button.pressed.connect(_on_confirmar_pressed)
	botao_voltar.pressed.connect(_on_voltar_pressed)

	_update_display(slider.value)

	AudioManager.falar(
		"Agora escolha a intensidade do que você está sentindo. "
		+ "Use o controle de zero a dez."
	)


func _on_slider_changed(value: float) -> void:
	_update_display(value)


func _update_display(value: float) -> void:
	var intensidade := int(value)

	valor_label.text = "%d/10" % intensidade

	var descricao := ""

	if value <= 3:
		descricao = "Leve"
	elif value <= 7:
		descricao = "Moderado"
	else:
		descricao = "Intenso"

	descricao_label.text = descricao


func _on_confirmar_pressed() -> void:
	print(
		"Intensidade confirmada: ",
		int(slider.value)
	)

	AudioManager.parar()

	GameState.selected_intensity = str(
		int(slider.value)
	)

	_ir_para_resultado()


func _ir_para_resultado() -> void:
	var app = get_tree().current_scene

	if app != null and app.has_method("load_screen"):
		queue_free()

		app.load_screen(
			"res://cenas/telas/ResultsFinal.tscn"
		)
	else:
		push_error(
			"App não encontrado para abrir ResultsFinal."
		)


func _on_voltar_pressed() -> void:
	print("Voltando do popup de intensidade")

	AudioManager.parar()
	queue_free()
