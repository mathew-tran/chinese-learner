extends Button


func _ready() -> void:
	_on_mouse_exited()
	
func _on_mouse_entered() -> void:
	$Label.visible = true


func _on_mouse_exited() -> void:
	$Label.visible = false
