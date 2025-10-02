extends TextureRect

class_name StatusSymbol

enum STATE {
	CORRECT,
	INCORRECT
}

func _ready() -> void:
	Hide()
	
func Hide():
	visible = false
	
func ShowState(state : STATE):
	if state == STATE.CORRECT:
		texture = load("res://Art/CorrectIcon.png")
	else:
		texture = load("res://Art/IncorrectIcon.png")
	visible = true
