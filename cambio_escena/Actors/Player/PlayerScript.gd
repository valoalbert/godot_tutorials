extends KinematicBody2D

# Properties for smooth movement initiation and stoping
const MAX_SPEED = 200
const JUMP_H = -600
const UP = Vector2(0, -1)
const GRAVITY = 30.0

# Character velocity
var motion = Vector2()

onready var animationPlayer = $AnimationPlayer
onready var player = $Sprite

func _ready():
	animationPlayer.play("Idle")
	pass

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		player.flip_h = false
		animationPlayer.play("Walk")
		motion.x = MAX_SPEED
	elif Input.is_action_pressed("ui_left"):
		player.flip_h = true
		animationPlayer.play("Walk")
		motion.x = -MAX_SPEED
	else:
		motion.x = 0
		animationPlayer.play("Idle")
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = JUMP_H
	else:
		animationPlayer.play("Jump")

	motion = move_and_slide(motion, UP)
	
	pass
