extends VBoxContainer


func Setup(value, totalValue):
	var percent = float(value) / float(totalValue)
	$GradeValue.text = Helper.GetGrade(percent)
	$Accuracy.text = "  (" + str(snapped((percent * 100), .01)) + "%)"
	$Stat.text = str(int(value)) + "/" + str(int(totalValue))
