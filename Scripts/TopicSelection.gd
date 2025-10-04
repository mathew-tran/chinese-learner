extends Panel

class_name SelectionScreen

@onready var Modules = $AvailableModules
var ModuleButtonClass = preload("res://Prefabs/ModuleButton.tscn")

signal ButtonPressed
signal ModulePressed(module)

func _ready() -> void:
	Setup()
	
func Setup():
	for module in Modules.get_children():
		module.queue_free()
	
	var AllModules = Helper.GetAllFilePaths("res://Content/Modules/")
	for module in AllModules:
		var instance = ModuleButtonClass.instantiate() as ModuleButton
		instance.Setup(load(module))
		Modules.add_child(instance)
		instance.Updated.connect(OnUpdated)
	OnUpdated()

func OnUpdated():
	var modules = GetSelectedModules()
	$StartButton.disabled = len(modules) == 0
	

func GetSelectedModules() -> Array[ModuleData]:
	var selectedModules : Array[ModuleData]
	for module in Modules.get_children():
		if module.IsSelected():
			selectedModules.append(module.ModuleRef)
	return selectedModules
	
func _on_start_button_button_up() -> void:
	ButtonPressed.emit()
	visible = false

func Refresh():
	for module in Modules.get_children():
		module.Refresh()
		
func _on_random_select_button_button_up() -> void:
	for module in Modules.get_children():
		module.SetSelection(ModuleButton.STATE.DESELECTED)
	
	var modulesToToggleOn = Modules.get_children()
	modulesToToggleOn.shuffle()
	
	var amountToToggle = randi_range(2, 5)
	while (len(modulesToToggleOn)) > amountToToggle:
		modulesToToggleOn.remove_at(0)
	
	for module in modulesToToggleOn:
		module.SetSelection(ModuleButton.STATE.SELECTED)
	


func _on_deselect_all_button_button_up() -> void:
	for module in Modules.get_children():
		module.SetSelection(ModuleButton.STATE.DESELECTED)


func _on_select_all_button_button_up() -> void:
	for module in Modules.get_children():
		module.SetSelection(ModuleButton.STATE.SELECTED)
