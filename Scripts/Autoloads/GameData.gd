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
	Save()
