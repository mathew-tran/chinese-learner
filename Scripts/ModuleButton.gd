extends Button

class_name ModuleButton

@export var ModuleRef : ModuleData

enum STATE {
	SELECTED,
	DESELECTED
}

var CurrentState = STATE.DESELECTED

signal Updated

func Setup(module : ModuleData):
	$Label.text = module.ModuleName
	ModuleRef = module
	ChangeState(STATE.DESELECTED)

func ChangeState(newState : STATE):
	CurrentState = newState
	if CurrentState == STATE.SELECTED:
		self_modulate = Color.WEB_GREEN
	else:
		self_modulate = Color.WHITE
	Updated.emit()

func IsSelected():
	return CurrentState == STATE.SELECTED
	
func _on_button_up() -> void:
	ChangeState(!CurrentState)

func SetSelection(newState : STATE):
	ChangeState(newState)
	
