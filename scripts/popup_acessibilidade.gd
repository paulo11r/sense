extends Control

@onready var botao_audio: Button = find_child("BotaoAudio", true, false)
@onready var botao_voz: Button = find_child("BotaoVoz", true, false)
@onready var slider_volume: HSlider = find_child("HSlider", true, false)
@onready var valor_volume: Label = find_child("ValorVolume", true, false)
@onready var botao_repetir: Button = find_child("BotaoRepetir", true, false)
@onready var botao_fechar: Button = find_child("BotaoFechar", true, false)


func _ready() -> void:
	botao_audio.toggle_mode = true
	botao_voz.toggle_mode = true

	botao_audio.set_pressed_no_signal(
		AcessibilityManager.audio_ativo
	)

	botao_voz.set_pressed_no_signal(
		AcessibilityManager.voz_guiada
	)

	slider_volume.min_value = 0
	slider_volume.max_value = 100

	slider_volume.set_value_no_signal(
		AcessibilityManager.volume * 100.0
	)

	_atualizar_volume(slider_volume.value)

	botao_audio.toggled.connect(_on_audio_toggled)
	botao_voz.toggled.connect(_on_voz_toggled)
	slider_volume.value_changed.connect(_on_volume_changed)
	botao_repetir.pressed.connect(_on_repetir_pressed)
	botao_fechar.pressed.connect(_on_fechar_pressed)

	_falar_instrucoes()


func _on_audio_toggled(ativado: bool) -> void:
	if ativado:
		AcessibilityManager.definir_audio_ativo(true)

		if AcessibilityManager.voz_guiada:
			AudioManager.falar("Áudio ativado.")
	else:
		if AcessibilityManager.audio_ativo and AcessibilityManager.voz_guiada:
			AudioManager.falar("Áudio desativado.")
			await get_tree().create_timer(2.0).timeout

		AcessibilityManager.definir_audio_ativo(false)


func _on_voz_toggled(ativado: bool) -> void:
	if ativado:
		AcessibilityManager.definir_voz_guiada(true)

		if AcessibilityManager.audio_ativo:
			AudioManager.falar("Voz guiada ativada.")
	else:
		if AcessibilityManager.voz_guiada and AcessibilityManager.audio_ativo:
			AudioManager.falar("Voz guiada desativada.")
			await get_tree().create_timer(2.0).timeout

		AcessibilityManager.definir_voz_guiada(false)


func _on_volume_changed(valor: float) -> void:
	AcessibilityManager.definir_volume(valor / 100.0)
	_atualizar_volume(valor)


func _atualizar_volume(valor: float) -> void:
	valor_volume.text = "%d%%" % int(valor)


func _on_repetir_pressed() -> void:
	_falar_instrucoes()


func _falar_instrucoes() -> void:
	AudioManager.falar(
		"Configurações de acessibilidade. "
		+ "Você pode ativar ou desativar o áudio, "
		+ "ativar ou desativar a voz guiada, "
		+ "ajustar o volume "
		+ "e repetir estas instruções."
	)


func _on_fechar_pressed() -> void:
	print("X da acessibilidade clicado")
	AudioManager.parar()
	queue_free()
