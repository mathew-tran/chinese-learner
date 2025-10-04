extends Resource

class_name ModuleData

@export var ModuleName = ""
@export_dir var Topic

func GetData():
	return Helper.GetAllFilePaths(Topic)

func GetModuleCompletionPercent():
	var data = GetData()
	var masteredSentences = 0
	var totalSentences = len(data)
	for sentence in data:
		var sentenceData = load(sentence) as SentenceData
		var gameResult = sentenceData.GetResultData()
		if gameResult:
			var resultData = ResultData.new()
			resultData.CombineResult(gameResult)
			if resultData.IsMastered():
				masteredSentences += 1
	return float(masteredSentences) / float(totalSentences)
