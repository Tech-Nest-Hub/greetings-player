extends HSlider

@export var audio_bus_name: String
# Called when the node enters the scene tree for the first time.
var audio_bus_id

func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)

func _on_value_changed(_value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id,db)
