extends TextEdit

class_name PlayerInput

signal OnEnterPressed

func _on_text_changed() -> void:
	print(text)
	if text.contains('\n'):
		text = text.replace('\n', '')
		OnEnterPressed.emit()
	


func _on_timer_timeout() -> void:
	grab_focus()
