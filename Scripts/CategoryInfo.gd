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
		
	var index = 0

	var sentences = ModuleRef.GetData()
	
	var hiddenSentences = 0
	var masteredSentences = 0
	var totalSentences = len(sentences)
	
	for sentence in sentences:
		var instance =  SentenceHistoryButtonClass.instantiate()
		var sentenceData = load(sentence) as SentenceData
		instance.SentenceRef = sentenceData
		SentenceHolder.add_child(instance)
		
		var sentenceResult = ResultData.new()
		
		if sentenceData.GetResultData():
			sentenceResult.CombineResult(sentenceData.GetResultData())
		
		if sentenceResult.IsMastered():
			masteredSentences += 1
		if sentenceResult.IsHidden():
			hiddenSentences += 1
			
		instance.SetupNumber(str(index + 1) + "/" + str(len(sentences)))
		index += 1
	
	$VBoxContainer/VBoxContainer/Total.Show("Total Sentences", totalSentences)
	$VBoxContainer/VBoxContainer/Mastered.Show("Mastered Sentences", masteredSentences)
	$VBoxContainer/VBoxContainer/Hidden.Show("Hidden Sentences", hiddenSentences)
	visible = true
	
	
func _on_exit_button_button_up() -> void:
	visible = false
