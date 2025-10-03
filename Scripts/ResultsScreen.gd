extends Panel

@onready var ResultContainer = $ScrollContainer/VBoxContainer
var WordResultButton = preload("res://Prefabs/WordResultButton.tscn")

signal OnContinueButtonPressed

func Show(results):
	var correct = 0
	var incorrect = 0
	var skips = 0
	for result in results:
		if result.HasPassed():
			correct += 1
		
		incorrect += result.Tries
		skips += result.Skipped
		
	var total = str(correct) + "/" + str(len(results))
	
	for result in ResultContainer.get_children():
		result.queue_free()
		
	var index = 0
	var length = len(results)
	for result in results:
		var text = str(index + 1) + "/" + str(length)
		index += 1
		var instance = WordResultButton.instantiate()
		ResultContainer.add_child(instance)
		instance.Show(result, text)
		instance.OnButtonPressed.connect(OnButtonPressed)
	var percent = float(correct) / float(len(results))
	var grade = GetGrade(percent)
	grade += "  (" + str(snapped((percent * 100), .01)) + "%)"
	
	$VBoxContainer/Correct.Show("Correct", correct)
	$VBoxContainer/Incorrect.Show("Incorrect", incorrect)
	$VBoxContainer/Skips.Show("Skips", skips)
	$VBoxContainer/Total.Show("Total", total)
	$VBoxContainer/Grade.Show("Grade", grade)
	visible = true

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
	
func OnButtonPressed(sentence):
	Helper.SaySentence(sentence.Sentence)
	
	


func _on_continue_button_button_up() -> void:
	OnContinueButtonPressed.emit()
