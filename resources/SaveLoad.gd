extends Node


const save_location = "user://SaveGame.tres"

var SaveFileData : SaveData = SaveData.new()

func _ready() -> void:
	_load()

func save() :
	ResourceSaver.save(SaveFileData, save_location)

func _load():
	if FileAccess.file_exists(save_location):
		SaveFileData = ResourceLoader.load(save_location).duplicate(true)
