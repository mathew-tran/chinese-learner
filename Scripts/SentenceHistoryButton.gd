extends Button

class_name SentenceHistoryButton

@export var SentenceRef : SentenceData

@onready var PinyinText = $HBoxContainer/VBoxContainer/Pinyin
@onready var TargetText = $HBoxContainer/VBoxContainer/TargetText
@onready var TranslatedText = $HBoxContainer/VBoxContainer/TranslatedText

func SetupNumber(text):
	$HBoxContainer/Label.text = text
	
func _ready() -> void:
	var result = GameData.GetSentenceResult(SentenceRef)
	var sentenceResult = ResultData.new()
	if result:		
		sentenceResult.CombineResult(result)
		PinyinText.text = SentenceRef.Pinyin
		TargetText.text = SentenceRef.Sentence
		TranslatedText.text = SentenceRef.TranslatedSentence
		$HBoxContainer/Panel.self_modulate = Color.WHITE		
		$HBoxContainer/Panel/GradeBox.Setup(sentenceResult.GetCorrectGuesses(), sentenceResult.GetTotalGuesses())
		$Mastered.visible = sentenceResult.IsMastered()
	else:
		PinyinText.text = "???"
		TargetText.text = "???"
		TranslatedText.text = "???"
		self_modulate = Color.DARK_GRAY
		$HBoxContainer/Panel.self_modulate = Color.BLACK
		$Mastered.visible = false
	
		


func _on_button_up() -> void:
	if PinyinText.text != "???":
		Helper.SaySentence(SentenceRef.Sentence)
