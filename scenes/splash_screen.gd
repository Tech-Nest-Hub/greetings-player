extends Node2D

func _ready():
	$SplashTimer.connect("timeout", Callable(self, "_on_SplashTimer_timeout"))

func _on_SplashTimer_timeout():
	# Change to the main scene after timer ends
	get_tree().change_scene_to_file("res://main_scene.tscn")
