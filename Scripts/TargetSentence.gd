extends Label

class_name TargetSentence

@export var Data : SentenceData
var mainVoice
var englishVoice

signal CompletedTalking

func _ready() -> void:
	var voices = DisplayServer.tts_get_voices_for_language("zh")
	var voice_id = voices[0]
	mainVoice = voice_id
	voices = DisplayServer.tts_get_voices_for_language("en")
	englishVoice = voices[0]
	
func SetSentence(data : SentenceData):
	text = data.Sentence
	Data = data
	SaySentence()
	
func SaySentence():
	DisplayServer.tts_speak(Data.Sentence, mainVoice)
	
func SayTranslatedSentence():
	DisplayServer.tts_speak(Data.TranslatedSentence, englishVoice)
	while DisplayServer.tts_is_speaking():
		await get_tree().create_timer(.1).timeout
	await get_tree().create_timer(1.5).timeout
	CompletedTalking.emit()
