extends Node

class_name ResultData

var Tries = 0
var Skipped = 0
var Correct = 0
var Sentence : SentenceData

func PrintResult():
	print(Sentence.Sentence + " tries " + str(Tries) + ", skipped: " + str(Skipped) + " correct: " + str(Correct))

func HasPassed():
	return Correct == 1 and Tries <= 0 and Skipped <= 0

func GetData():
	return {
		"Tries" : Tries,
		"Skipped" : Skipped,
		"Correct" : Correct,
	}
	
func LoadData(data):
	Tries = data["Tries"]
	Skipped = data["Skipped"]
	Correct = data["Correct"]
	
	
func CombineResult(resultDataJSON):
	Tries += resultDataJSON["Tries"]
	Skipped += resultDataJSON["Skipped"]
	Correct += resultDataJSON["Correct"]
	
func GetCorrectGuesses():
	return Correct

func GetTotalGuesses():
	var result = Correct + Skipped + Tries
	return result
	
func GetGrade():
	if GetTotalGuesses() == 0:
		return "???"
	return Helper.GetGrade(float(GetCorrectGuesses())/ float(GetTotalGuesses()))
	
func IsMastered():
	return GetCorrectGuesses() >= 1 and GetGrade() == "A"
	
func IsHidden():
	return GetTotalGuesses() == 0
	
func GetFailStatusString():
	var str = ""
	if Tries > 0:
		str += "tries: " + str(Tries) + "| "
	if Skipped > 0:
		str += "skipped"
	return str
