extends Node2D

@export var Sentence : SentenceData

@export var TargetText : TargetSentence
@export var PlayerText : PlayerInput
@export var TranslatedText : Label

func _ready() -> void:
	TargetText.SetSentence(Sentence)
	TranslatedText.text = ""
	
func _on_text_edit_on_enter_pressed() -> void:
	if(PlayerText.text == TargetText.text):
		print("CORRECT!")
		TargetText.SayTranslatedSentence()
		TranslatedText.text = Sentence.TranslatedSentence
	else:
		print("INCORRECT!")
		TargetText.SaySentence()
		PlayerText.text = ""
