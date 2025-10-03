extends TextEdit

class_name PlayerInput

signal OnEnterPressed

func _on_text_changed() -> void:
	print(text)
	if text.contains('\n'):
		text = text.replace('\n', '')
		OnEnterPressed.emit()
	
func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		release_focus()
		await get_tree().create_timer(.1).timeout
		get_window().set_ime_active(false)
		grab_focus()

func _on_timer_timeout() -> void:
	if has_focus() == false:
		grab_focus()
