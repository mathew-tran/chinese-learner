extends Button


func _on_button_up() -> void:
	GameData.Clear()
	get_tree().reload_current_scene()
