extends Control

@onready var slider: Range = $PainelPopup/Margens/Conteudo/SliderIntensidade
@onready var valor_label: Label = $PainelPopup/Margens/Conteudo/ValorIntensidade
@onready var descricao_label: Label = $PainelPopup/Margens/Conteudo/DescricaoIntensidade
@onready var confirmar_button: Button = $PainelPopup/Margens/Conteudo/AreaConfirmar/BotaoConfirmar

func _ready() -> void:
	slider.value_changed.connect(_on_slider_changed)
	confirmar_button.pressed.connect(_on_confirmar_pressed)
	_update_display(slider.value)

func _on_slider_changed(value: float) -> void:
	_update_display(value)

func _update_display(value: float) -> void:
	valor_label.text = "%d/10" % int(value)

	if value <= 3:
		descricao_label.text = "Leve"
	elif value <= 7:
		descricao_label.text = "Moderado"
	else:
		descricao_label.text = "Intenso"

func _on_confirmar_pressed() -> void:
	GameState.selected_intensity = str(int(slider.value))
	
