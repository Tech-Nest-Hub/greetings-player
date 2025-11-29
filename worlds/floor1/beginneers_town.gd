extends Node2D

@onready var animFountain: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	_on_player_entered_new_area("res://worlds/floor1/beginneers_town.tscn")

func _process(delta: float) -> void:
	animFountain.play("fountain_animation")
	pass


func _on_player_entered_new_area(scene_path: String) -> void:
	SaveLoad.SaveFileData.last_scene = scene_path
	SaveLoad.save()
