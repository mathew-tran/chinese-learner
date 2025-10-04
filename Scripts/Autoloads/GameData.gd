extends Node

var Data = {}

var SavePath = "user://savegame.save"

var bLoaded = false

signal OnLoaded

func _ready() -> void:
	Load()
	
func Save():
	var saveFile = FileAccess.open(SavePath, FileAccess.WRITE)
	saveFile.store_line(JSON.stringify(Data))
	
func Clear():
	Data.clear()
	Save()
	
func Load():
	if FileAccess.file_exists(SavePath) == false:
		pass
	else:
		var loadFile = FileAccess.open(SavePath, FileAccess.READ)
		var json = JSON.new()
		var parsedJSON = json.parse(loadFile.get_line())
		if not parsedJSON == OK:
			print(json.get_error_message())
		else:
			Data = json.data
	OnLoaded.emit()
	bLoaded = true
	
func GetResultData():
	if Data.has("Results"):
		return Data["Results"]
	Data["Results"] = {}
	
func GetSentenceResult(sentence : SentenceData):
	var resourceID = sentence.GetUniqueID()
	GetResultData()
	if Data.has("Results"):		
		if Data["Results"].has(resourceID):
			return Data["Results"][resourceID]
	return ResultData.new().GetData()
	
func UpdateResult(resultData : ResultData):
	var resourceID = resultData.Sentence.GetUniqueID()
	GetResultData()
	if Data.has("Results"):		
		if Data["Results"].has(resourceID):
			var cachedResult = Data["Results"][resourceID]
			resultData.CombineResult(cachedResult)
		Data["Results"][resourceID] = resultData.GetData()
			
func AwaitValue(key):
	while bLoaded == false:
		await get_tree().create_timer(.1).timeout
	return GetValue(key)
	
func GetValue(key):
	if(Data.has(key)):
		return Data[key]
	return null

func SetValue(key, value):
	Data[key] = value
