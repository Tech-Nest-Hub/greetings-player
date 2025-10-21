extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

const SPEED = 150
var last_direction = "down"

func _physics_process(delta):
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

	# Animation logic
	if dir == Vector2.ZERO:
		anim.play("idle_" + last_direction)
	else:
		play_walk_animation(dir)


func play_walk_animation(dir: Vector2):
	# Pick the dominant direction
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			anim.play("walk_right")
			last_direction = "right"
		else:
			anim.play("walk_left")
			last_direction = "left"
	else:
		if dir.y > 0:
			anim.play("walk_right_down")
			last_direction = "down"
		else:
			anim.play("walk_up")
			last_direction = "up"
