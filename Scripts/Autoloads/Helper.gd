extends Node

var MainVoice
var EnglishVoice

signal CompletedTalking

func _ready() -> void:
	var voices = DisplayServer.tts_get_voices_for_language("zh")
	var voice_id = voices[0]
	MainVoice = voice_id
	voices = DisplayServer.tts_get_voices_for_language("en")
	EnglishVoice = voices[0]
	
func SaySentence(words):
	DisplayServer.tts_stop()
	DisplayServer.tts_speak(words, MainVoice)
	
func SayTranslatedSentence(words):
	DisplayServer.tts_stop()
	DisplayServer.tts_speak(words, EnglishVoice)
	while DisplayServer.tts_is_speaking():
		await get_tree().create_timer(.1).timeout
	await get_tree().create_timer(1.5).timeout
	CompletedTalking.emit()
	
func GetAllFilePaths(path: String) -> Array[String]:
	var file_paths: Array[String] = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		file_name = file_name.trim_suffix('.remap')
		var file_path = path + "/" + file_name
		if dir.current_is_dir():
			file_paths += GetAllFilePaths(file_path)
		else:
			file_paths.append(file_path)
		file_name = dir.get_next()
	return file_paths
	
func GetGradeText(percent):
	var str = GetGrade(percent)
	str += "  (" + str(snapped((percent * 100), .01)) + "%)"
	return str
	
func GetGrade(percent):
	percent *= 100
	if percent <= 59.9:
		return "F"
	if percent <= 69.9:
		return "D"
	if percent <= 79.9:
		return "C"
	if percent <= 89.9:
		return "B"
	return "A"
	
	
