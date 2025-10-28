extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons.visible = true
	options.visible = false



func _on_start_pressed() -> void:
	SaveLoad.SaveFileData = SaveData.new()
	SaveLoad.SaveFileData.player_name = "Aakash"
	SaveLoad.SaveFileData.last_scene = "res://worlds/starting_scene.tscn"
	SaveLoad.save()
	TransitionFadeinFadeout.start_loading(SaveLoad.SaveFileData.last_scene)
	


func _on_options_pressed() -> void:
	main_buttons.visible = false
	options.visible = true


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	_ready()


func _on_continue_pressed() -> void:
		SaveLoad._load()
		if SaveLoad.SaveFileData.last_scene == "":
			SaveLoad.SaveFileData.last_scene = "res://worlds/starting_scene.tscn"
			
		TransitionFadeinFadeout.start_loading(SaveLoad.SaveFileData.last_scene)
		
