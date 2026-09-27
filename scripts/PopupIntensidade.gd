extends Control

@onready var slider: HSlider = $PainelPopup/Margens/Conteudo/SliderIntensidade
@onready var valor_label: Label = $PainelPopup/Margens/Conteudo/ValorIntensidade
@onready var descricao_label: Label = $PainelPopup/Margens/Conteudo/ValorIntensidade/DescricaoIntensidade
@onready var confirmar_button: Button = $PainelPopup/Margens/Conteudo/AreaConfirmar/BotaoConfirmar
@onready var botao_voltar: Button = $PainelPopup/Margens/Conteudo/BotaoVoltar

var popup_confirmacao_scene := preload(
	"res://cenas/componentes/PopupConfirmacao.tscn"
)

var popup_confirmacao: Control = null


func _ready() -> void:
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
	AudioManager.parar()

	GameState.selected_intensity = str(int(slider.value))

	if is_instance_valid(popup_confirmacao):
		return

	popup_confirmacao = popup_confirmacao_scene.instantiate()

	popup_confirmacao.tipo_confirmacao = "intensidade"

	add_child(popup_confirmacao)


func _on_voltar_pressed() -> void:
	AudioManager.parar()
	queue_free()
