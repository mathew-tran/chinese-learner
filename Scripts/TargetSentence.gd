extends Label

class_name TargetSentence

@export var Data : SentenceData

signal CompletedTalking


	
func SetSentence(data : SentenceData):
	text = data.Sentence
	Data = data
	Helper.SaySentence(data.Sentence)
	
