extends Node2D

@export var Sentence : SentenceData

@export var TargetText : TargetSentence
@export var PlayerText : PlayerInput
@export var TranslatedText : Label
@export var AnswerSymbol : StatusSymbol

var AllSentences = []

var Index = 0
var tryAmount = 0


	
func ChooseNextSentence():
	if Index >= len(AllSentences):
		print("You have won")
		return
	Sentence = load(AllSentences[Index])
	print(Sentence.resource_path + " loaded")
	TargetText.SetSentence(Sentence)
	TranslatedText.text = ""
	AnswerSymbol.Hide()
	PlayerText.text = ""
	$Panel/ProgressBar.value = Index
	$Panel/ProgressBar.max_value = len(AllSentences)
	$Panel/Pinyin.text = ""
	Index += 1
	PlayerText.editable = true
	tryAmount = 0

	
func Retry():
	await get_tree().create_timer(1.5).timeout
	PlayerText.editable = true
	AnswerSymbol.Hide()
	ShowPinyin()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("F1"):
		TargetText.SaySentence()
		FailAttempt()
	if event.is_action_pressed("F2"):
		ChooseNextSentence()
		
func _on_text_edit_on_enter_pressed() -> void:
	PlayerText.editable = false
	if(PlayerText.text == TargetText.text):
		print("CORRECT!")
		
		TranslatedText.text = Sentence.TranslatedSentence
		AnswerSymbol.ShowState(StatusSymbol.STATE.CORRECT)
		TargetText.SayTranslatedSentence()
		$Panel/GoodSFX.play()
		ShowPinyin()
	else:
		print("INCORRECT!")
		TargetText.SaySentence()
		PlayerText.text = ""
		AnswerSymbol.ShowState(StatusSymbol.STATE.INCORRECT)
		Retry()
		$Panel/BadSFX.play()
		
func FailAttempt():
	tryAmount += 1
	if(tryAmount >= 3):
		ShowPinyin()
		
func ShowPinyin():
	$Panel/Pinyin.text = Sentence.Pinyin

func _on_target_sentence_completed_talking() -> void:
	ChooseNextSentence()


func _on_selection_button_pressed() -> void:
	var modules = $Selection.GetSelectedModules()
	AllSentences.clear()
	for module in modules:
		var files = module.GetData()
		for file in files:
			AllSentences.append(file)
	for x in AllSentences:
		print(x)
	AllSentences.shuffle()
	ChooseNextSentence()
