extends Control

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_greeting_name: Label = $PlayerName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_wdelta: float) -> void:
	animated_sprite_2d.play("Male_Player")
	player_greeting_name.text = Global.player_name
