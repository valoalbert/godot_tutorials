extends KinematicBody2D

const ACCELERATION = 1000
const MAX_SPEED = 400
const FRICTION = 1000

var velocity = Vector2.ZERO
var inputVector = Vector2.ZERO
var isMoving = false
var direction = "down"

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

func _physics_process(delta):
	control_loop(delta)

func control_loop(delta):
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized()

	if inputVector != Vector2.ZERO:
		velocity = inputVector * MAX_SPEED
		animationPlayer.play("Walk")
		if Input.is_action_pressed("ui_right"):
			sprite.flip_h = false
		if Input.is_action_pressed("ui_left"):
			sprite.flip_h = true
		
	else:
		velocity = Vector2.ZERO
		animationPlayer.play("Idle")
		
	move_and_collide(velocity * delta)
