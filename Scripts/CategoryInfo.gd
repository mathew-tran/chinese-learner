extends Panel

var ModuleRef : ModuleData

@onready var SentenceHolder = $ScrollContainer/VBoxContainer
var SentenceHistoryButtonClass = preload("res://Prefabs/SentenceHistoryButton.tscn")

func Update(moduleToShow):
	ModuleRef = moduleToShow
	$ScrollContainer.scroll_vertical = 0
	$Title.text = ModuleRef.ModuleName
	
	for sentence in SentenceHolder.get_children():
		sentence.queue_free()
		
	for sentence in ModuleRef.GetData():
		var instance =  SentenceHistoryButtonClass.instantiate()
		instance.SentenceRef = load(sentence)
		SentenceHolder.add_child(instance)
	
	visible = true
	
	
func _on_exit_button_button_up() -> void:
	visible = false
