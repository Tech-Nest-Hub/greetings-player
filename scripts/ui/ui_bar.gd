extends Control

@onready var animated_sprite_2d: AnimatedSprite2D = $PlayerInfoBox/AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	animated_sprite_2d.play("Male_Player")
