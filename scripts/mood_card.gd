extends PanelContainer

func _on_btn_happy_pressed() -> void:
	AudioManager.falar("Estou me sentindo feliz.")


func _on_btn_calm_pressed() -> void:
	AudioManager.falar("Estou me sentindo calmo.")


func _on_btn_nauseous_pressed() -> void:
	AudioManager.falar("Estou me sentindo enjoado")


func _on_btn_sad_pressed() -> void:
	AudioManager.falar("Estou me sentindo triste.")


func _on_btn_anxious_pressed() -> void:
	AudioManager.falar("Estou me sentindo ansioso!")
