extends VBoxContainer

func _ready() -> void:
	var result = await GameData.AwaitValue("bShowLanguagePopup") 
	if result != null and result == false:
		queue_free()
		
func _on_button_button_up() -> void:
	OS.shell_open("https://support.microsoft.com/en-us/windows/language-packs-for-windows-a5094319-a92d-18de-5b53-1cfc697cfca8")


func _on_close_button_button_up() -> void:
	GameData.SetValue("bShowLanguagePopup", false)
	queue_free()
