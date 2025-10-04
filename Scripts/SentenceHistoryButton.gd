extends Button

class_name SentenceHistoryButton

@export var SentenceRef : SentenceData

@onready var PinyinText = $HBoxContainer/VBoxContainer/Pinyin
@onready var TargetText = $HBoxContainer/VBoxContainer/TargetText
@onready var TranslatedText = $HBoxContainer/VBoxContainer/TranslatedText

func _ready() -> void:
	var result = GameData.GetSentenceResult(SentenceRef)
	if result:
		PinyinText.text = SentenceRef.Pinyin
		TargetText.text = SentenceRef.Sentence
		TranslatedText.text = SentenceRef.TranslatedSentence
		$HBoxContainer/Panel.self_modulate = Color.WHITE
		
		var sentenceResult = ResultData.new()
		sentenceResult.CombineResult(result)
		$HBoxContainer/Panel/GradeBox.Setup(sentenceResult.GetCorrectGuesses(), sentenceResult.GetTotalGuesses())
	else:
		PinyinText.text = "???"
		TargetText.text = "???"
		TranslatedText.text = "???"
		self_modulate = Color.DARK_GRAY
		$HBoxContainer/Panel.self_modulate = Color.BLACK
		
		


func _on_button_up() -> void:
	if PinyinText.text != "???":
		Helper.SaySentence(SentenceRef.Sentence)
