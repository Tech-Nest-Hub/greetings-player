extends Node2D

@onready var actionable_finder: Area2D = $MalePlayer/DIRECTION/ActionableFinder
@onready var first_spawner: Area2D = $"First Spawner"
@onready var terrians: Node2D = $Terrians
@onready var male_player: CharacterBody2D = $MalePlayer
@onready var timer: Timer = $Timer
@onready var fade_rect: ColorRect = $FadeRect
@onready var press_k: Panel = $Stand/PressK
@onready var stand_area: Area2D = $Stand




var has_triggered_dialogue
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	press_k.visible = false
		# Optional: Connect signals in code if not done in editor
	if not stand_area.area_entered.is_connected(_on_stand_area_entered):
		stand_area.area_entered.connect(_on_stand_area_entered)
	if not stand_area.area_exited.is_connected(_on_stand_area_exited):
		stand_area.area_exited.connect(_on_stand_area_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not has_triggered_dialogue:
		_before_cut_scene()
		var action = actionable_finder.get_overlapping_areas()
		if action.size() > 0:
			has_triggered_dialogue = true
			action[0].action()
			first_spawner.hide()
			timer.wait_time = 5
			timer.start()
			await timer.timeout
			_after_cut_scene()
			return 

	if Input.is_action_just_pressed("ui_interact_dialogue"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return 

func _before_cut_scene() -> void:
	terrians.hide()
	male_player.hide()
	await fade_out(1.5)

func _after_cut_scene()-> void:
	first_spawner.hide()
	await fade_in(1.5)
	
	timer.wait_time = 1
	timer.start()
	await timer.timeout
	terrians.show()
	timer.wait_time = 2
	timer.start()
	await timer.timeout
	male_player.show()


func fade_in(_duration: float) -> void:
	fade_rect.visible = true
	fade_rect.modulate.a = 1.0
	fade_rect.show()
	fade_rect.modulate.a = 1.0
	# Animate alpha to 0 using Timer
	var steps = 20
	for i in range(steps):
		await get_tree().process_frame
		fade_rect.modulate.a = 0.0
	fade_rect.hide()
	
func fade_out(_duration: float) -> void:
	fade_rect.visible = true
	fade_rect.modulate.a = 0.0
	fade_rect.show()
	var steps = 20
	for i in range(steps):
		await get_tree().process_frame
		fade_rect.modulate.a = 1.0

func go_to_floorone()-> void:
	SaveLoad.SaveFileData.last_scene = "res://worlds/floor1/beginneers_town.tscn"
	SaveLoad.save()
	TransitionFadeinFadeout.start_loading(SaveLoad.SaveFileData.last_scene)
	


func _on_stand_area_entered(_area: Area2D) -> void:
	press_k.visible = true



func _on_stand_area_exited(_area: Area2D) -> void:
	press_k.visible = false
