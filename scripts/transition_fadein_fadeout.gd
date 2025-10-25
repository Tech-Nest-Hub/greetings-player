extends CanvasLayer

signal scene_loaded

@onready var timer: Timer = $Timer
@onready var label: Label = $Label
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dots_count: int = 0
var scene_path : String = ""
var loading_status: int = 0
var scene_ready_to_load: bool = false
var loaded_scene: PackedScene 


func _ready() -> void:
	hide()
	set_process(false)
	
	timer.timeout.connect(_on_dots_timer_timeout)
	animated_sprite_2d.play("idle_down")
	
func _process(_delta: float) -> void:
	loading_status = ResourceLoader.load_threaded_get_status(scene_path)
	match loading_status:
		ResourceLoader.THREAD_LOAD_LOADED:
			_on_scene_loaded()
		ResourceLoader.THREAD_LOAD_FAILED:
			push_error("OU NOU GAME CRASH JINGALLA ULLU LALA")

func start_loading(path:String) -> void:
	scene_path = path
	show()
	set_process(true)
	timer.start()
	label.text = "loading"
	
	ResourceLoader.load_threaded_request(scene_path)

func _on_dots_timer_timeout() -> void:
	dots_count = (dots_count + 1)%4
	var dots = ""
	match dots_count:
		0: 
			dots = ""
		1: 
			dots = "."
		2: 
			dots = ".."
		3: 
			dots = "..."
	label.text = "loading Resources" + dots
	
func _on_scene_loaded()-> void:
	loaded_scene = ResourceLoader.load_threaded_get(scene_path)
	scene_ready_to_load = true
	_change_scene()
	
func _on_artificial_delay_timer() -> void:
	if scene_ready_to_load:
		_change_scene()
	
func _change_scene() -> void:
	set_process(false)
	timer.stop()
	
	var current_scene = get_tree().current_scene
	var scene_instance = loaded_scene.instantiate()
	get_tree().root.add_child(scene_instance)
	get_tree().current_scene= scene_instance
	
	current_scene. queue_free()
	hide()
	
	scene_path = ""
	scene_ready_to_load = false
	loaded_scene = null
	scene_loaded.emit()
