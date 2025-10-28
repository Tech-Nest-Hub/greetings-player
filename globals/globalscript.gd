extends Node


var player_name: String = "Player"

func _ready() -> void:
	# Load saved data when game starts
	SaveLoad._load()
	player_name = SaveLoad.SaveFileData.player_name

func _save_player() -> void:
	SaveLoad.SaveFileData.player_name = player_name
	SaveLoad.save()
	print("Saved player name GLOBAL HO HAI: ", player_name)  # Debug line
