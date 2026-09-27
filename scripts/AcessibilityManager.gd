extends Node

var audio_ativo: bool = true
var voz_guiada: bool = true
var volume: float = 1.0

signal audio_ativo_alterado(valor: bool)
signal voz_guiada_alterada(valor: bool)
signal volume_alterado(valor: float)


func definir_audio_ativo(valor: bool) -> void:
	audio_ativo = valor
	audio_ativo_alterado.emit(valor)

	if not audio_ativo:
		DisplayServer.tts_stop()


func definir_voz_guiada(valor: bool) -> void:
	voz_guiada = valor
	voz_guiada_alterada.emit(valor)

	if not voz_guiada:
		DisplayServer.tts_stop()


func definir_volume(valor: float) -> void:
	volume = clamp(valor, 0.0, 1.0)
	volume_alterado.emit(volume)
