extends Button

signal OnButtonPressed(sentence)

var storedResult
func Show(result : ResultData, indexText):
	storedResult = result
	$IndexText.text = indexText
	$TargetText.text = result.Sentence.Sentence
	$TranslatedText.text = result.Sentence.TranslatedSentence
	$FailStatuses.text = ""
	if result.HasPassed():
		$TextureRect.texture = load("res://Art/CorrectIcon.png")
	else:
		$TextureRect.texture = load("res://Art/IncorrectIcon.png")
		$FailStatuses.text = result.GetFailStatusString()


func _on_button_up() -> void:
	OnButtonPressed.emit(storedResult.Sentence)
