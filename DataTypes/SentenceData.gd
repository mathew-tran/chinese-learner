extends Resource

class_name SentenceData

@export_multiline var Sentence = ""
@export_multiline var TranslatedSentence = ""
@export_multiline var Pinyin = ""

func GetUniqueID():
	return resource_path.split("/")[-1]
