extends Resource

class_name ModuleData

@export var ModuleName = ""
@export_dir var Topic

func GetData():
	return Helper.GetAllFilePaths(Topic)
