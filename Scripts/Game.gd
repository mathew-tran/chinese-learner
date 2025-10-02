extends Node2D

@export var Sentence : SentenceData

@export var TargetText : TargetSentence
@export var PlayerText : PlayerInput
@export var TranslatedText : Label
@export var AnswerSymbol : StatusSymbol

var AllSentences

var Index = 0
func _ready() -> void:
	AllSentences = Helper.GetAllFilePaths("res://Content/Easy/")
	for x in AllSentences:
		print(x)
	AllSentences.shuffle()
	ChooseNextSentence()
	
func ChooseNextSentence():
	if Index >= len(AllSentences):
		print("You have won")
		return
	Sentence = load(AllSentences[Index])
	TargetText.SetSentence(Sentence)
	TranslatedText.text = ""
	AnswerSymbol.Hide()
	PlayerText.text = ""
	Index += 1
	PlayerText.editable = true
	
func Retry():
	await get_tree().create_timer(1.5).timeout
	PlayerText.editable = true
	AnswerSymbol.Hide()
	
func _on_text_edit_on_enter_pressed() -> void:
	PlayerText.editable = false
	if(PlayerText.text == TargetText.text):
		print("CORRECT!")
		
		TranslatedText.text = Sentence.TranslatedSentence
		AnswerSymbol.ShowState(StatusSymbol.STATE.CORRECT)
		
		TargetText.SayTranslatedSentence()
	else:
		print("INCORRECT!")
		TargetText.SaySentence()
		PlayerText.text = ""
		AnswerSymbol.ShowState(StatusSymbol.STATE.INCORRECT)
		Retry()


func _on_target_sentence_completed_talking() -> void:
	ChooseNextSentence()
