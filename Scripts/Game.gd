extends Node2D

@export var Sentence : SentenceData

@export var TargetText : TargetSentence
@export var PlayerText : PlayerInput
@export var TranslatedText : Label
@export var AnswerSymbol : StatusSymbol

var AllSentences = []

var Index = 0

var Results = []
var CurrentResult : ResultData

	
func ChooseNextSentence():
	if CurrentResult:
		Results.append(CurrentResult)
		CurrentResult = null
		
	if Index >= len(AllSentences):
		print("You have won")
		for x in Results:
			x.PrintResult()
		$ResultsScreen.Show(Results)
		return

	Sentence = load(AllSentences[Index])
	CurrentResult = ResultData.new()
	CurrentResult.Sentence = Sentence
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

	
func Retry():
	await get_tree().create_timer(1.5).timeout
	PlayerText.editable = true
	AnswerSymbol.Hide()
	ShowPinyin()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("F1"):
		Helper.SaySentence(Sentence.Sentence)
		TargetText.SaySentence()
		FailAttempt()
	if event.is_action_pressed("F2"):
		CurrentResult.Skipped += 1
		ChooseNextSentence()
		
func _on_text_edit_on_enter_pressed() -> void:
	PlayerText.editable = false
	if(PlayerText.text == TargetText.text):
		print("CORRECT!")
		
		TranslatedText.text = Sentence.TranslatedSentence
		AnswerSymbol.ShowState(StatusSymbol.STATE.CORRECT)
		Helper.SayTranslatedSentence(Sentence.TranslatedSentence)
		$Panel/GoodSFX.play()
		CurrentResult.Correct += 1
		ShowPinyin()
		await Helper.CompletedTalking
		ChooseNextSentence()
	else:
		print("INCORRECT!")
		Helper.SayTranslatedSentence(Sentence.Sentence)
		PlayerText.text = ""
		AnswerSymbol.ShowState(StatusSymbol.STATE.INCORRECT)
		Retry()
		CurrentResult.Tries += 1
		$Panel/BadSFX.play()
		
func FailAttempt():
	CurrentResult.Tries += 1
	if(CurrentResult.Tries >= 3):
		ShowPinyin()
		
func ShowPinyin():
	$Panel/Pinyin.text = Sentence.Pinyin



func _on_selection_button_pressed() -> void:
	var modules = $Selection.GetSelectedModules()
	AllSentences.clear()
	Index = 0
	for module in modules:
		var files = module.GetData()
		for file in files:
			AllSentences.append(file)
	for x in AllSentences:
		print(x)
	AllSentences.shuffle()
	var maxAmount = 10
	maxAmount = clamp(len(AllSentences), len(AllSentences), maxAmount)
	while len(AllSentences) > maxAmount:
		AllSentences.remove_at(0)
	ChooseNextSentence()


func _on_results_screen_on_continue_button_pressed() -> void:
	$ResultsScreen.visible = false
	$Selection.visible = true
