extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var tween = get_tree().create_tween()
@onready var health_bar: Control = $UiBar/VBoxContainer/HP
@onready var actionable_finder: Area2D = $DIRECTION/ActionableFinder


const SPEED = 175
var last_direction = "down"
var max_health = 100
var current_health = max_health

func _ready() -> void:
	health_bar.init_health(max_health)

func take_damage(amount: int):
	current_health = max(current_health - amount, 0)
	health_bar.health = current_health
	
	if current_health <= 0:
		die()

func heal(amount: int):
	current_health = min(current_health + amount, max_health)
	health_bar.health = current_health

func die():
	anim.play("death_normal_down")
	anim.hide()
	queue_free()

func _physics_process(_delta):

			
	var dir = Vector2.ZERO
	# Movement input
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1

	dir = dir.normalized()
	velocity = dir * SPEED
	move_and_slide()
	
		# Jump input
	if Input.is_action_just_pressed("ui_jump"):
		start_jump()
		
	if Input.is_action_just_pressed("take_damage"):
		take_damage(10)
		

	# Animation logic
	if dir == Vector2.ZERO:
		anim.play("idle_" + last_direction)
	else:
		play_walk_animation(dir)


func play_walk_animation(dir: Vector2):
	# Handle diagonals first
	if dir.x > 0 and dir.y < 0:
		anim.play("walk_right_up")
		last_direction = "right_up"
	elif dir.x > 0 and dir.y > 0:
		anim.play("walk_right_down")
		last_direction = "right_down"
	elif dir.x < 0 and dir.y < 0:
		anim.play("walk_left_up")
		last_direction = "left_up"
	elif dir.x < 0 and dir.y > 0:
		anim.play("walk_left_down")
		last_direction = "left_down"
	# Handle straight directions
	elif dir.x > 0:
		anim.play("walk_right_down")
		last_direction = "right_down"
	elif dir.x < 0:
		anim.play("walk_left_down")
		last_direction = "left_down"
	elif dir.y > 0:
		anim.play("walk_down")
		last_direction = "down"
	elif dir.y < 0:
		anim.play("walk_up")
		last_direction = "up"


func start_jump():
	var start_y = position.y
	var jump_height = 25

	# fake up & down motion
	tween.tween_property(self, "position:y", start_y - jump_height, 0.15)
	tween.tween_property(self, "position:y", start_y, 0.15)
	tween.tween_callback(Callable(self, "_end_jump"))
