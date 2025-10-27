extends Area2D

const Ballon = preload("res://worlds/dialogues/balloon.tscn")
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start_first_time"

# Step 1: Define a signal for when dialogue finishes
signal dialogue_finished

func action() -> void:
	var ballon : Node = Ballon.instantiate()
	get_tree().current_scene.add_child(ballon)
	ballon.start(dialogue_resource, dialogue_start)
	ballon.connect("finished", Callable(self, "_on_dialogue_finished"))
	
func _on_dialogue_finished() -> void:
	emit_signal("dialogue_finished")
