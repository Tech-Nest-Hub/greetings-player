extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons.visible = true
	options.visible = false



func _on_start_pressed() -> void:
		# Load the saved data before transitioning
	SaveLoad._load()
	
	# Now you can access the loaded player name
	print("Loaded player name: ", SaveLoad.SaveFileData.player_name)
	TransitionFadeinFadeout.start_loading("res://worlds/starting_scene.tscn")
	


func _on_options_pressed() -> void:
	main_buttons.visible = false
	options.visible = true


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	_ready()
