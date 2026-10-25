extends Node

var voz_id: String = ""
var ultimo_texto: String = ""


func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	_configurar_voz()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		DisplayServer.tts_stop()
        
	elif what == NOTIFICATION_APPLICATION_PAUSED:
		DisplayServer.tts_stop()


func _configurar_voz() -> void:
	var vozes := DisplayServer.tts_get_voices_for_language("pt")

	if vozes.size() > 0:
		voz_id = vozes[0]


func falar(texto: String, interromper: bool = true) -> void:
	if not AcessibilityManager.audio_ativo:
		return

	if not AcessibilityManager.voz_guiada:
		return

	if texto.strip_edges().is_empty():
		return

	ultimo_texto = texto

	if interromper:
		DisplayServer.tts_stop()

	if voz_id.is_empty():
		_configurar_voz()

	if voz_id.is_empty():
		push_warning("Nenhuma voz em português foi encontrada no sistema.")
		return

	var volume_tts := int(AcessibilityManager.volume * 100.0)

	DisplayServer.tts_speak(
		texto,
		voz_id,
		volume_tts
	)


func atualizar_volume() -> void:
	if ultimo_texto.is_empty():
		return

	DisplayServer.tts_stop()
	falar(ultimo_texto)


func repetir() -> void:
	if ultimo_texto.is_empty():
		return

	falar(ultimo_texto)


func parar() -> void:
	DisplayServer.tts_stop()
